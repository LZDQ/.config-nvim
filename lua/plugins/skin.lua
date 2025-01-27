return { {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	priority = 500,
	opts = {
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
				statusline = 10,
				tabline = 10,
				winbar = 10,
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
		extensions = {},
	},
	config = function(_, opts)
		local lualine = require('lualine')
		lualine.setup(opts)
		vim.api.nvim_create_autocmd("OptionSet", {
			pattern = "background",
			callback = function()
				-- vim.notify(vim.o.background)
				if vim.o.background == 'dark' then
					lualine.setup { options = { theme = 'ayu_mirage' } }
				else
					lualine.setup { options = { theme = 'gruvbox' } }
				end
			end,
		})
	end
}, {
	"lukas-reineke/indent-blankline.nvim",
	main = 'ibl',
	event = 'VeryLazy',
	opts = {
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
}, {
	"LZDQ/umbra.nvim",
	-- lazy = true,
	dev = false,
	opts = {
		-- Main options --
		style = 'impure',       -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
		transparent = false,    -- Show/hide background
		term_colors = true,     -- Change terminal color as per the selected theme style
		ending_tildes = false,  -- Show the end-of-buffer tildes. By default they are hidden
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
}, {
	"sainnhe/sonokai", lazy = true,
	init = function()
		vim.g.sonokai_enable_italic = false
		-- vim.g.sonokai_style = 'andromeda'
		-- vim.g.sonokai_better_performance = true
	end
}, {
	"sainnhe/everforest", lazy = true,
	init = function()
		vim.g.everforest_background = 'hard'
		-- vim.g.everforest_better_performance = true
	end
}, {
	"sainnhe/edge", lazy = true,
	init = function()
		vim.g.edge_style = 'neon'
		vim.g.edge_dim_foreground = true
		vim.g.edge_enable_italic = false
		-- vim.g.edge_better_performance = true
	end
}, {
	"morhetz/gruvbox", lazy = true,
	init = function()
		vim.g.gruvbox_contrast_light = 'soft'
	end
}, { "folke/tokyonight.nvim", lazy = true,
}, { "catppuccin/nvim", name = "catppuccin", lazy = true,
}, { "EdenEast/nightfox.nvim", lazy = true,
}, { "rebelot/kanagawa.nvim", lazy = true,
}, { "nyoom-engineering/oxocarbon.nvim", lazy = true,
}, { "savq/melange-nvim", lazy = true,
}, { "marko-cerovac/material.nvim", lazy = true,
}, { "Mofiqul/dracula.nvim", lazy = true,
}, { "AlexvZyl/nordic.nvim", lazy = true,
}, { "rmehri01/onenord.nvim", lazy = true,
}, { "projekt0n/github-nvim-theme", lazy = true,
}, {
	"zaldih/themery.nvim",
	opts = {
		themes = {
			"umbra",
			"edge",
			"catppuccin-frappe",
			"catppuccin-macchiato",
			"sonokai",
			"tokyonight-moon",
			"tokyonight-storm",
			"tokyonight-night",
			"github_dark",
			"github_dark_dimmed",
			"material-palenight",
			"dracula-soft",
			"everforest",
			"kanagawa-dragon",
			"nordic",
			"onenord",
			"nightfox",
			"duskfox",
			"terafox",
			"oxocarbon",
			"tokyonight-day",
			"kanagawa-lotus",
			"melange",
			"material-lighter",
			"github_light",
			"gruvbox",
		},            -- Your list of installed colorschemes
		-- themeConfigFile = "~/.config/nvim/lua/settings/theme.lua", -- Described below
		livePreview = true, -- Apply theme while browsing. Default to true.
	},
	init = function()
		vim.keymap.set('n', '<leader>t', '<CMD>Themery<CR>')
	end,
	-- cmd = "Themery"
}, {
	"mvllow/modes.nvim",
	enabled = true,
	event = 'ModeChanged',
	opts = {
		-- Set opacity for cursorline and number background
		line_opacity = 0.15,

		-- Enable cursor highlights
		set_cursor = true,

		-- Enable cursorline initially, and disable cursorline for inactive windows
		-- or ignored filetypes
		set_cursorline = false,

		-- Enable line number highlights to match cursorline
		set_number = false,

		-- Disable modes highlights in specified filetypes
		-- Please PR commonly ignored filetypes
		ignore_filetypes = { 'NvimTree', 'TelescopePrompt' }
	}
} }
