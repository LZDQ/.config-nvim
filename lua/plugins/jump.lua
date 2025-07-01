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
		vim.keymap.set('n', 'S', '<Plug>(leap)')
		vim.keymap.set('n', '<leader>S', '<Plug>(leap-from-window)')
	end,
	keys = { "S", "<leader>S" }
}, {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-telescope/telescope-live-grep-args.nvim",
	},
	config = function()
		local actions = require('telescope.actions')
		local telescope = require('telescope')
		telescope.setup {
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
				},
			},
			pickers = {
				colorscheme = {
					enable_preview = true
				}
			},
			extensions = {
				live_grep_args = {
					additional_args = {
						"--glob", "!lazy-lock.json"
					}
				}
			},
		}
		telescope.load_extension("live_grep_args")
	end,
	init = function()
		vim.keymap.set('n', ';F', "<CMD>Telescope find_files<CR>")
		vim.keymap.set('n', ';g', "<CMD>Telescope live_grep_args<CR>")
		vim.keymap.set('n', ';B', "<CMD>Telescope buffers<CR>")
		vim.keymap.set('n', ';t', "<CMD>Telescope builtin<CR>")
		vim.keymap.set('n', ';k', "<CMD>Telescope keymaps<CR>")
	end,
	cmd = "Telescope"
}, {
	"nvim-telescope/telescope-live-grep-args.nvim",
	lazy = true
}, {
	"junegunn/fzf",
	lazy = true,
	build = "./install --all",
}, {
	"junegunn/fzf.vim",             -- Vim integration for fzf
	dependencies = { "junegunn/fzf" }, -- Ensure fzf is loaded first
	cmd = { 'Files', 'Rg', 'Buffers', 'Lines' },
	init = function()
		vim.env.FZF_DEFAULT_OPTS =
		'--bind ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-h:backward-char,ctrl-l:forward-char'
		vim.keymap.set('n', ';f', "<CMD>Files<CR>")
		vim.keymap.set('n', ';G', "<CMD>Rg<CR>")
		vim.keymap.set('n', ';b', "<CMD>Buffers<CR>")
		vim.keymap.set('n', ';l', "<CMD>Lines<CR>")
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
		vim.keymap.set('n', 'f', '<Plug>(clever-f-f)')
		vim.keymap.set('n', 'F', '<Plug>(clever-f-F)')
	end,
	keys = { "f", "F" }
}, {
	"kelly-lin/ranger.nvim",
	opts = { enable_cmds = true },
	keys = {
		{ 'R', '<CMD>Ranger<CR>' },
		{ '<leader>R', 'R', noremap = true }, -- remap the builtin key
	}
} }
