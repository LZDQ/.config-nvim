return { {
	"sindrets/diffview.nvim",
	enabled = false,
	opts = {
		use_icons = false,
	}
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
		-- Keys: <leader>g to show diff, [c and ]c to jump to diffs
		vim.keymap.set('n', '<leader>g', function()
			gitsigns.toggle_signs()
			gitsigns.toggle_deleted()
			-- gitsigns.toggle_linehl()
			gitsigns.toggle_current_line_blame()
		end, { noremap = true })
		vim.keymap.set('n', ']m', function()
			gitsigns.nav_hunk('next')
		end, { noremap = true })
		vim.keymap.set('n', '[m', function()
			gitsigns.nav_hunk('prev')
		end, { noremap = true })
	end
} }
