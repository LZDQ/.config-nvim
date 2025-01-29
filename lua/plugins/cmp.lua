return { {
	"hrsh7th/nvim-cmp",
	event = {
		-- "VeryLazy",
		"InsertEnter",
		"CmdlineEnter",
		"TermEnter",
	},
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/vim-vsnip',
		'lukas-reineke/cmp-under-comparator',
	},
	config = function()
		local cmp = require 'cmp'
		-- From https://github.com/hrsh7th/nvim-cmp/discussions/1834
		-- and https://github.com/hrsh7th/nvim-cmp/issues/156#issuecomment-916338617
		local lspkind_comparator = function(conf)
			local lsp_types = require("cmp.types").lsp
			return function(entry1, entry2)
				if entry1.source.name ~= "nvim_lsp" then
					if entry2.source.name == "nvim_lsp" then
						return false
					else
						return nil
					end
				end
				local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
				local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]
				if kind1 == "Variable" and entry1:get_completion_item().label:match("%w*=") then
					kind1 = "Parameter"
				end
				if kind2 == "Variable" and entry2:get_completion_item().label:match("%w*=") then
					kind2 = "Parameter"
				end

				local priority1 = conf.kind_priority[kind1] or 0
				local priority2 = conf.kind_priority[kind2] or 0
				if priority1 == priority2 then
					return nil
				end
				return priority2 < priority1
			end
		end


		cmp.setup {
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-10),
				['<C-f>'] = cmp.mapping.scroll_docs(10),
				-- ['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<Tab>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_next_item()
						--elseif vim.fn["vsnip#available"](1) == 1 then
						--feedkey("<Plug>(vsnip-expand-or-jump)", "")
						--elseif has_words_before() then
						--cmp.complete()
					else
						cmp.complete() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
						--elseif vim.fn["vsnip#jumpable"](-1) == 1 then
						--feedkey("<Plug>(vsnip-jump-prev)", "")
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				-- { name = 'vsnip' }, -- For vsnip users.
				-- { name = 'luasnip' }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
			}, {
				--{ name = 'buffer' },
			}, {
				{ name = 'path' },
			}),
			sorting = {
				-- From github
				priority_weight = 2,
				comparators = {
					cmp.config.compare.exact,
					lspkind_comparator({
						kind_priority = {
							Parameter = 14,
							Snippet = 13,
						},
					}),
					cmp.config.compare.score,
					cmp.config.compare.length,
					require "cmp-under-comparator".under,
					cmp.config.compare.recently_used,
					cmp.config.compare.offset,
					cmp.config.compare.locality,
					--cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					--cmp.config.compare.order,
				}
			}
		}

		-- Set configuration for specific filetype.
		cmp.setup.filetype('gitcommit', {
			sources = cmp.config.sources({
				{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
			}, {
				{ name = 'buffer' },
			})
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			}),
			matching = { disallow_symbol_nonprefix_matching = false }
		})
	end
}, {
	"zbirenbaum/copilot.lua",
	opts = {
		panel = {
			enabled = true,
			auto_refresh = true,
			keymap = {
				jump_prev = "[[",
				jump_next = "]]",
				accept = "<CR>",
				-- refresh = "<F5>",
				-- open = "<leader>p",
			},
			layout = {
				position = "right", -- | top | left | right
				ratio = 0.4
			},
		},
		suggestion = {
			enabled = false,
		},
		filetypes = {
			yaml = false,
			markdown = false,
			help = false,
			gitcommit = false,
			gitrebase = false,
			hgcommit = false,
			svn = false,
			cvs = false,
		},
		copilot_node_command = 'node', -- Node.js version must be > 18.x
		server_opts_overrides = {},
	},
	init = function()
		vim.keymap.set('n', '<leader>p', '<CMD>Copilot panel<CR>')
	end,
	cmd = "Copilot"
}, {
	"alvan/vim-closetag",
	init = function ()
		vim.g.closetag_filetypes = 'html,xml,xhtml,phtml'
	end,
	ft = { "html", "xml" },
} }
