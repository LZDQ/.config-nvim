require('Comment').setup {
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



local autopairs = require('nvim-autopairs')
autopairs.setup {
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	disable_in_macro = true,     -- disable when recording or executing a macro
	disable_in_visualblock = false, -- disable when insert after visual block mode
	disable_in_replace_mode = true,
	ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
	enable_moveright = true,
	enable_afterquote = true,      -- add bracket pairs after quote
	enable_check_bracket_line = true, --- check bracket in same line
	enable_bracket_in_quote = true, --
	enable_abbr = false,           -- trigger abbreviation
	break_undo = true,             -- switch for basic rule break undo sequence
	check_ts = false,
	map_cr = true,
	map_bs = true, -- map the <BS> key
	map_c_h = false, -- map the <C-h> key to delete a pair
	map_c_w = false, -- map <c-w> to delete a pair if possible
}


-- vim.api.nvim_set_keymap('i', '<CR>', "v:lua.require'nvim-autopairs'.completion_confirm()", { expr = true, noremap = true })




local cryptoprice = require("cryptoprice")
cryptoprice.setup {
	base_currency = "usd",
	-- crypto_list = { "bitcoin", "ethereum", "the-open-network" },
	window_height = 10,
	window_width = 60
}
vim.g.cryptoprice_crypto_list = { "bitcoin", "ethereum", "the-open-network" }


-- Convert the cwd to a simple file name
local function get_cwd_as_name()
	local dir = vim.fn.getcwd(0)
	return dir:gsub("[^A-Za-z0-9]", "_")
end
local overseer = require("overseer")

vim.keymap.set('n', '\'', overseer.toggle, { noremap = true })
vim.keymap.set('n', ';r', overseer.run_template, { noremap = true })

require("auto-session").setup({
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
})

require('usage-tracker').setup({
	keep_eventlog_days = 14,
	cleanup_freq_days = 7,
	event_wait_period_in_sec = 5,
	inactivity_threshold_in_min = 5,
	inactivity_check_freq_in_sec = 5,
	verbose = 0,
	telemetry_endpoint = "" -- you'll need to start the restapi for this feature
})

require("link-visitor").setup {
	open_cmd = nil,
	--[[
	1. cmd to open url
	defaults:
	win or wsl: cmd.exe /c start
	mac: open
	linux: xdg-open
	2. a function to handle the link
	the function signature: func(link: string)
	--]]
	silent = true,         -- disable all prints, `false` by defaults skip_confirmation
	skip_confirmation = true, -- Skip the confirmation step, default: false
	border = "rounded"     -- none, single, double, rounded, solid, shadow see `:h nvim_open_win()`
}
vim.keymap.set('n', ';v', ':VisitLinkNearCursor<CR>', { noremap = true, silent = true })

-- CTF
local hex = require 'hex'
hex.setup {
	-- cli command used to dump hex data
	-- dump_cmd = 'xxd -g 1 -u',

	-- cli command used to assemble from hex data
	-- assemble_cmd = 'xxd -r',

	-- function that runs on BufReadPre to determine if it's binary or not
	is_file_binary_pre_read = function()
		binary_ext = { 'bin', 'png', 'jpg', 'jpeg', 'exe', 'dll' }
		-- only work on normal buffers
		if vim.bo.ft ~= "" then return false end
		-- check -b flag
		if vim.bo.bin then return true end
		-- check ext within binary_ext
		local filename = vim.fn.expand('%:t')
		local ext = vim.fn.expand('%:e')
		if vim.tbl_contains(binary_ext, ext) then return true end
		-- none of the above
		return false
	end,

	-- function that runs on BufReadPost to determine if it's binary or not
	-- is_file_binary_post_read = function()
	-- end,
}

vim.keymap.set('n', 'X', hex.toggle)

require('bigfile').setup {
	-- Default size limit in bytes
	size_limit = 1 * 1024 * 1024, -- 1MB

	-- Per-filetype size limits
	ft_size_limits = {
		-- javascript = 100 * 1024, -- 100KB for javascript files
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

require('numb').setup {}
require('presence').setup {}

require('showkeys').setup {
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
}
