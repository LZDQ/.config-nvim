return { {
	"sindrets/diffview.nvim",
	init = function ()
		local actions = require('diffview.actions')
		local lib = require('diffview.lib')
		-- vim.opt.fillchars:append { diff = "╱" }

		vim.keymap.set("n", "<DEL>", function()
			if lib.get_current_view() then
				vim.cmd("DiffviewClose")
			else
				vim.cmd("DiffviewOpen")
			end
		end, { desc = "Toggle Diffview" })

		require('diffview').setup {
			use_icons = false,
			signs = {
				fold_closed = "> ",
				fold_open = "| ",
				done = "✓",
			},
			file_panel = {
				listing_style = "list"
			},
			enhanced_diff_hl = true,
			keymaps = {
				disable_defaults = true,
				file_panel = {
					{ "n", "<Home>",     actions.scroll_view(-0.99) },
					{ "n", "<PageUp>",   actions.scroll_view(-0.5) },
					{ "n", "<PageDown>", actions.scroll_view(0.5) },
					{ "n", "<End>",      actions.scroll_view(0.99) },
					{ "n", "<up>",       actions.select_prev_entry },
					{ "n", "<down>",     actions.select_next_entry },
					{ "n", "<tab>",      actions.select_next_entry },
					{ "n", "<s-tab>",    actions.select_prev_entry },
					{ "n", "r",          actions.refresh_files },
					{ "n", "'",          actions.toggle_files },
					{ "n", "q",          "<CMD>DiffviewClose<CR>" },
					{ "n", "l",          actions.select_entry },
				},
				view = {
					{ "n", "<tab>",      actions.select_next_entry },
					{ "n", "<s-tab>",    actions.select_prev_entry },
					{ "n", "r",          actions.refresh_files },
					{ "n", "'",          actions.toggle_files },
					{ "n", "q",          actions.close },
				}
			},
			hooks = {
				view_opened = function() vim.g.focus_disable = true end,
				view_enter  = function() vim.g.focus_disable = true  end,
				view_closed = function() vim.g.focus_disable = false end,
				view_leave  = function() vim.g.focus_disable = false end,
			},
		}
	end
}, {
	"lewis6991/gitsigns.nvim",
	event = 'VeryLazy',
	opts = {
		signs                        = {
			add          = { text = '+' },
			change       = { text = '~' },
			delete       = { text = '-' },
			topdelete    = { text = '‾' },
			changedelete = { text = '-' },
			untracked    = { text = '┆' },
		},
		signs_staged                 = {
			add          = { text = '+' },
			change       = { text = '~' },
			delete       = { text = '-' },
			topdelete    = { text = '‾' },
			changedelete = { text = '-' },
			untracked    = { text = '┆' },
		},
		signs_staged_enable          = false,
		signcolumn                   = false, -- Toggle with `:Gitsigns toggle_signs`
		numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir                 = {
			follow_files = true
		},
		auto_attach                  = true,
		attach_to_untracked          = false,
		current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts      = {
			virt_text = true,
			virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
			virt_text_priority = 100,
			use_focus = true,
		},
		current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
		sign_priority                = 6,
		update_debounce              = 100,
		status_formatter             = nil, -- Use default
		max_file_length              = 40000, -- Disable if file is longer than this (in lines)
		preview_config               = {
			-- Options passed to nvim_open_win
			border = 'single',
			style = 'minimal',
			relative = 'cursor',
			row = 0,
			col = 1
		},
	},
	config = function(_, opts)
		local gitsigns = require('gitsigns')
		gitsigns.setup(opts)
		-- Keys: <leader>g to show diff, [g and ]g to jump to diffs
		vim.keymap.set('n', '<leader>g', function()
			gitsigns.toggle_signs()
			gitsigns.toggle_deleted()
			-- gitsigns.toggle_linehl()
			gitsigns.toggle_current_line_blame()
		end, { noremap = true })
		vim.keymap.set('n', ']g', function()
			gitsigns.nav_hunk('next')
		end, { noremap = true })
		vim.keymap.set('n', '[g', function()
			gitsigns.nav_hunk('prev')
		end, { noremap = true })
	end
} }
