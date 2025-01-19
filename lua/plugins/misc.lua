return { {
	"numToStr/Comment.nvim",
	event = 'VeryLazy',
	opts = {
		---Add a space b/w comment and the line
		padding = true,
		---Whether the cursor should stay at its position
		sticky = true,
		---Lines to be ignored while (un)comment
		ignore = nil,
		---LHS of toggle mappings in NORMAL mode
		toggler = {
			---Line-comment toggle keymap
			line = ',',
			---Block-comment toggle keymap
			-- block = 'gcb',
			block = nil,
		},
		---LHS of operator-pending mappings in NORMAL and VISUAL mode
		opleader = {
			---Line-comment keymap
			line = ',',
			---Block-comment keymap
			block = '<leader>,',
		},
		---LHS of extra mappings
		extra = {
			---Add comment on the line above
			above = 'cO',
			---Add comment on the line below
			below = 'co',
			---Add comment at the end of line
			eol = 'c,',
		},
		---Enable keybindings
		---NOTE: If given `false` then the plugin won't create any mappings
		mappings = {
			---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
			basic = true,
			---Extra mapping; `gco`, `gcO`, `gcA`
			extra = true,
		},
		---Function to call before (un)comment
		pre_hook = nil,
		---Function to call after (un)comment
		post_hook = nil,
	}
}, {
	"windwp/nvim-autopairs",
	event = 'VeryLazy',
	opts = {
		disable_filetype = { "TelescopePrompt", "spectre_panel" },
		disable_in_macro = true,  -- disable when recording or executing a macro
		disable_in_visualblock = false, -- disable when insert after visual block mode
		disable_in_replace_mode = true,
		ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
		enable_moveright = true,
		enable_afterquote = true,   -- add bracket pairs after quote
		enable_check_bracket_line = true, --- check bracket in same line
		enable_bracket_in_quote = true, --
		enable_abbr = false,        -- trigger abbreviation
		break_undo = true,          -- switch for basic rule break undo sequence
		check_ts = false,
		map_cr = true,
		map_bs = true, -- map the <BS> key
		map_c_h = false, -- map the <C-h> key to delete a pair
		map_c_w = false, -- map <c-w> to delete a pair if possible
	}
}, {
	"gaborvecsei/cryptoprice.nvim",
	opts = {
		base_currency = "usd",
		-- crypto_list = { "bitcoin", "ethereum", "the-open-network" },
		window_height = 10,
		window_width = 60
	},
	init = function()
		vim.g.cryptoprice_crypto_list = { "bitcoin", "ethereum", "the-open-network" }
	end,
	cmd = "CryptoPriceToggle"
}, {
	"rmagatti/auto-session",
	dependencies = { "stevearc/overseer.nvim" },
	config = function()
		local function get_cwd_as_name()
			local dir = vim.fn.getcwd(0)
			return dir:gsub("[^A-Za-z0-9]", "_")
		end
		local overseer = require("overseer")

		require("auto-session").setup {
			-- lazy_support = false,
			pre_save_cmds = {
				function()
					overseer.save_task_bundle(
						get_cwd_as_name(),
						-- Passing nil will use config.opts.save_task_opts. You can call list_tasks() explicitly and
						-- pass in the results if you want to save specific tasks.
						nil,
						{ on_conflict = "overwrite" } -- Overwrite existing bundle, if any
					)
				end,
			},
			-- Optionally get rid of all previous tasks when restoring a session
			pre_restore_cmds = {
				function()
					for _, task in ipairs(overseer.list_tasks({})) do
						task:dispose(true)
					end
				end,
			},
			post_restore_cmds = {
				function()
					overseer.load_task_bundle(get_cwd_as_name(), { ignore_missing = true, autostart = false })
				end,
			},
			session_lens = {
				load_on_setup = false
			},
		}
	end,
}, {
	"gaborvecsei/usage-tracker.nvim",
	event = 'VeryLazy'
}, {
	"xiyaowong/link-visitor.nvim",
	opts = {
		silent = true,      -- disable all prints, `false` by defaults skip_confirmation
		skip_confirmation = true, -- Skip the confirmation step, default: false
	},
	init = function()
		vim.keymap.set('n', ';v', ':VisitLinkNearCursor<CR>', { noremap = true, silent = true })
	end,
	cmd = "VisitLinkNearCursor"
}, {
	"RaafatTurki/hex.nvim",
	opts = {
		-- cli command used to dump hex data
		-- dump_cmd = 'xxd -g 1 -u',

		-- cli command used to assemble from hex data
		-- assemble_cmd = 'xxd -r',

		-- function that runs on BufReadPre to determine if it's binary or not
		is_file_binary_pre_read = function()
			local binary_ext = { 'bin', 'png', 'jpg', 'jpeg', 'exe', 'dll' }
			-- only work on normal buffers
			if vim.bo.ft ~= "" then return false end
			-- check -b flag
			if vim.bo.bin then return true end
			-- check ext within binary_ext
			-- local filename = vim.fn.expand('%:t')
			local ext = vim.fn.expand('%:e')
			if vim.tbl_contains(binary_ext, ext) then return true end
			-- none of the above
			return false
		end,

		-- function that runs on BufReadPost to determine if it's binary or not
		-- is_file_binary_post_read = function()
		-- end,
	},
	init = function()
		vim.keymap.set('n', 'X', ':HexToggle<CR>', { silent = true, noremap = true })
	end,
	cmd = 'HexToggle'
}, {
	"ouuan/nvim-bigfile",
	opts = {
		-- Default size limit in bytes
		size_limit = 1024 * 1024 * 1024,

		-- Per-filetype size limits
		ft_size_limits = {
			javascript = 1024 * 1024, -- 100KB for javascript files
		},

		-- Show notifications when big files are detected
		notification = true,

		-- Enable basic syntax highlighting (not TreeSitter) for big files
		-- (tips: it will be automatically disabled if too slow)
		syntax = true,

		-- Custom additional hook function to run when big files are detected
		hook = nil,
		-- hook = function(buf, ft)
		--   vim.b.minianimate_disable = true
		-- end,
	}
}, {
	"mistricky/codesnap.nvim",
	build = "make",
	-- event = 'VeryLazy'
	cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapASCII", "CodeSnapHighlight", "CodeSnapSaveHighlight" },
}, {
	"nacro90/numb.nvim",
	opts = {},
	event = 'CmdlineEnter'
}, {
	"NStefan002/screenkey.nvim",
	cmd = "Screenkey"
}, {
	"nvzone/showkeys",
	opts = {
		winopts = {
			focusable = false,
			relative = "editor",
			style = "minimal",
			border = "single",
			height = 1,
			row = 1,
			col = 0,
		},

		timeout = 3, -- in secs
		maxkeys = 8,
		show_count = true,
		excluded_modes = {}, -- example: {"i"}

		-- bottom-left, bottom-right, bottom-center, top-left, top-right, top-center
		position = "bottom-right",

		keyformat = {
			["<BS>"] = "BS",
			["<CR>"] = "CR",
			["<Space>"] = "Space",
			["<Up>"] = "Up",
			["<Down>"] = "Down",
			["<Left>"] = "Left",
			["<Right>"] = "Right",
			["<PageUp>"] = "PgUp",
			["<PageDown>"] = "PgDn",
			["<M>"] = "Alt",
			["<C>"] = "Ctrl",
		},
	},
	cmd = "ShowkeysToggle"
}, {
	"andweeb/presence.nvim",
	-- enabled = false,
	event = 'VeryLazy',
}, {
	"bkad/CamelCaseMotion",
	event = 'VeryLazy',
	config = function()
		-- nnoremap > <Plug>CamelCaseMotion_w
		-- nnoremap < <Plug>CamelCaseMotion_b
		vim.keymap.set('n', '>', '<Plug>CamelCaseMotion_w', { noremap = true })
		vim.keymap.set('n', '<', '<Plug>CamelCaseMotion_b', { noremap = true })
	end
}, {
	"kana/vim-smartword",
	event = 'VeryLazy',
	config = function()
		vim.keymap.set('n', 'w', '<Plug>(smartword-w)', { noremap = true })
		vim.keymap.set('n', 'b', '<Plug>(smartword-b)', { noremap = true })
	end
}, {
	"LudoPinelli/comment-box.nvim",
	--               +-----------------------------------------------+
	--               |        :CB[lrc][lrca](box|line)[style]        |
	--               |       Use :CBcatalog to view all styles       |
	--               | box ASCII style is 10, line ASCII style is 17 |
	--               +-----------------------------------------------+
	event = 'VeryLazy',
	config = function ()
		vim.keymap.set('v', '<leader>b', ':CBcabox10<CR>', { noremap = true, silent = true })
	end
}, { "vim-scripts/restore_view.vim"
}, { "tpope/vim-surround", event = 'VeryLazy'
}, { "AndrewRadev/splitjoin.vim", lazy = false,
}, { "vim-scripts/ReplaceWithRegister", keys = 'gr', --event = 'VeryLazy'
}, {
	"hrsh7th/nvim-pasta",
	config = function ()
		vim.keymap.set('n', 'p', require('pasta.mapping').p)
		vim.keymap.set('n', 'P', require('pasta.mapping').P)
		require('pasta').config.next_key = vim.keycode('p')
		require('pasta').config.prev_key = vim.keycode('P')
	end,
}, }
