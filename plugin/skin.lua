-- lualine, onedark/tokyo, cmdline

local lualine = require('lualine')
lualine.setup {
	options = {
		icons_enabled = false,
		theme = 'ayu_mirage',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}

-- Automatic switch to gruvbox (desert) in light bg, and ayu_mirage in dark bg
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function ()
		-- vim.notify(vim.o.background)
		if vim.o.background == 'dark' then
			lualine.setup{options={theme='ayu_mirage'}}
		else
			lualine.setup{options={theme='gruvbox'}}
		end
	end,
})

local umbra = require('umbra')

umbra.setup {
	-- Main options --
	style = 'impure',          -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	transparent = false,       -- Show/hide background
	term_colors = true,        -- Change terminal color as per the selected theme style
	ending_tildes = false,     -- Show the end-of-buffer tildes. By default they are hidden
	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

	-- toggle theme style ---
	toggle_style_key = '!', -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
	toggle_style_list = {
		'newmoon',
		'jeanne',
		'impure',
		'fullmoon',
		'lite',
		-- 'deep',
		-- 'warm',
		'warmer',
		-- 'dark',
		-- 'darker',
		'cool',
		'light',
	}, -- List of styles to toggle between

	-- Change code style ---
	-- Options are italic, bold, underline, none
	-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
	code_style = {
		comments = 'italic',
		keywords = 'none',
		functions = 'none',
		strings = 'none',
		variables = 'none'
	},

	-- Lualine options --
	lualine = {
		transparent = false, -- lualine center bar transparency
	},

	-- Custom Highlights --
	colors = {}, -- Override default colors
	highlights = {
		-- For all options, see
	}, -- Override highlight groups

	-- Plugins Config --
	diagnostics = {
		darker = true, -- darker colors for diagnostic
		undercurl = true, -- use undercurl instead of underline for diagnostics
		background = true, -- use background color for virtual text
	},
}

-- umbra.load()

-- local tokyo = require('tokyonight')

require("ibl").setup {
	scope = {
		enabled = true,
		show_start = false,
		show_end = false,
		exclude = {
			language = { "python" }
		}
	},
	-- whitespace = { highlight = { "Normal", "Whitespace",  } },
	-- indent = { highlight = { "Normal" } },
}

vim.g.sonokai_enable_italic = false
-- vim.g.sonokai_style = 'andromeda'
-- vim.g.sonokai_better_performance = true

vim.g.everforest_background = 'hard'
-- vim.g.everforest_better_performance = true

vim.g.edge_style = 'neon'
vim.g.edge_dim_foreground = true
vim.g.edge_enable_italic = false
-- vim.g.edge_better_performance = true

vim.g.gruvbox_contrast_light = 'soft'

require("themery").setup {
	themes = {
		"umbra",
		"edge",
		"catppuccin-frappe",
		"catppuccin-macchiato",
		"sonokai",
		"tokyonight-moon",
		"tokyonight-storm",
		"tokyonight-night",
		"everforest",
		"kanagawa-dragon",
		"nightfox",
		"duskfox",
		"terafox",
		"oxocarbon",
		"tokyonight-day",
		"kanagawa-lotus",
		"gruvbox",
	},               -- Your list of installed colorschemes
	-- themeConfigFile = "~/.config/nvim/lua/settings/theme.lua", -- Described below
	livePreview = true, -- Apply theme while browsing. Default to true.
}

vim.keymap.set('n', '<leader>!', ':Themery<CR>', { noremap = true, silent = true })
