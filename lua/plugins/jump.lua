local keymap_opts = { silent = true, noremap = true }

return { {
	"ctrlpvim/ctrlp.vim",
	keys = "<C-P>",
	init = function()
		vim.g.ctrlp_working_path_mode = 'ra'
		vim.g.ctrlp_map = '<C-P>'
		vim.g.ctrlp_cmd = 'CtrlPMixed'
	end
}, {
	"ggandor/leap.nvim",
	config = function()
		local leap = require('leap')
		leap.opts.safe_labels = 'fnugzmwebt/FHLUNSBWETQ?'
		-- leap.opts.labels = 'fnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?'
		leap.opts.labels = ''
		vim.keymap.set('n', 'S', '<Plug>(leap)', keymap_opts)
		vim.keymap.set('n', '<leader>S', '<Plug>(leap-from-window)', keymap_opts)
	end,
	event = 'VeryLazy',
	-- keys = { "S", "<leader>S" }
}, {
	"nvim-telescope/telescope.nvim",
	config = function()
		local actions = require('telescope.actions')
		require('telescope').setup {
			defaults = {
				mappings = {
					n = {
						["q"] = actions.close,
					},
					i = {
						["<esc>"] = actions.close,
						["<C-J>"] = actions.move_selection_next,
						["<C-K>"] = actions.move_selection_previous,
						["<C-F>"] = actions.preview_scrolling_down,
						["<C-B>"] = actions.preview_scrolling_up,
					}
				}
			},
			pickers = {
				colorscheme = {
					enable_preview = true
				}
			}
		}
	end,
	init = function()
		vim.keymap.set('n', ';F', ":Telescope find_files<CR>", keymap_opts)
		vim.keymap.set('n', ';g', ":Telescope live_grep<CR>", keymap_opts)
		vim.keymap.set('n', ';B', ":Telescope buffers<CR>", keymap_opts)
		vim.keymap.set('n', ';t', ":Telescope builtin<CR>", keymap_opts)
		vim.keymap.set('n', ';k', ":Telescope keymaps<CR>", keymap_opts)
	end,
	cmd = "Telescope"
}, {
	"junegunn/fzf",
	lazy = true,
	build = "./install --all",
}, {
	"junegunn/fzf.vim",             -- Vim integration for fzf
	dependencies = { "junegunn/fzf" }, -- Ensure fzf is loaded first
	event = 'VeryLazy',
	init = function()
		vim.env.FZF_DEFAULT_OPTS =
		'--bind ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-h:backward-char,ctrl-l:forward-char'
		vim.keymap.set('n', ';f', ":Files<CR>", keymap_opts)
		vim.keymap.set('n', ';G', ":Rg<CR>", keymap_opts)
		vim.keymap.set('n', ';b', ":Buffers<CR>", keymap_opts)
		vim.keymap.set('n', ';l', ":Lines<CR>", keymap_opts)
	end
}, {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	opts = {},
	lazy = true,
	init = function()
		-- local harpoon = require('harpoon')
		-- harpoon:setup()
		vim.keymap.set("n", ";a", function() require('harpoon'):list():add() end, keymap_opts)
		vim.keymap.set("n", ";h", function()
			require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
		end, keymap_opts)
		-- Switch to harpoon buffer
		vim.keymap.set("n", ";1", function() require('harpoon'):list():select(1) end, keymap_opts)
		vim.keymap.set("n", ";2", function() require('harpoon'):list():select(2) end, keymap_opts)
		vim.keymap.set("n", ";3", function() require('harpoon'):list():select(3) end, keymap_opts)
		vim.keymap.set("n", ";4", function() require('harpoon'):list():select(4) end, keymap_opts)
		-- Switch to previous & next buffers stored within Harpoon list
		vim.keymap.set("n", ";p", function() require('harpoon'):list():prev() end, keymap_opts)
		vim.keymap.set("n", ";n", function() require('harpoon'):list():next() end, keymap_opts)
	end
}, {
	"rhysd/clever-f.vim",
	init = function()
		vim.g.clever_f_not_overwrites_standard_mappings = 1
		vim.g.clever_f_across_no_line = 1
		vim.g.clever_f_timeout_ms = 1500
		vim.g.clever_f_highlight_timeout_ms = vim.g.clever_f_timeout_ms
	end,
	config = function()
		vim.keymap.set('n', 'f', '<Plug>(clever-f-f)', { noremap = true })
		vim.keymap.set('n', 'F', '<Plug>(clever-f-F)', { noremap = true })
	end,
	event = 'VeryLazy',
	-- keys = { "f", "F" }
} }
