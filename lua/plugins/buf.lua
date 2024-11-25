return { {
	"akinsho/bufferline.nvim",
	config = function()
		local bufferline = require('bufferline')
		bufferline.setup {
			options = {
				-- Disable icons
				show_buffer_icons = false, -- to hide the buffer icons
				show_buffer_close_icons = false, -- to hide the close icons
				show_close_icon = false, -- to hide the close icon on the right side of the bufferline
				show_tab_indicators = true, -- to hide tab indicators (if you want)
				-- other options...
				style_preset = bufferline.style_preset.no_italic,
			}
		}
	end
}, {
	"elihunter173/dirbuf.nvim",
	opts = {
		hash_padding = 2,
		show_hidden = true,
		sort_order = "default",
		write_cmd = "DirbufSync",
	},
	init = function()
		vim.keymap.set('n', ';d', function()
			-- If filetype is already 'dirbuf', close it. Otherwise open it
			if vim.bo.filetype == 'dirbuf' then
				vim.cmd('DirbufQuit')
			else
				vim.cmd('Dirbuf')
			end
		end)
	end,
	cmd = "Dirbuf",
}, {
	"folke/noice.nvim",
	event = 'VeryLazy',
	opts = {
		cmdline = {
			enabled = true, -- enables the Noice cmdline UI
			view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
			opts = {},     -- global options for the cmdline. See section on views
			---@type table<string, CmdlineFormat>
			format = {
				-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
				-- view: (default is cmdline view)
				-- opts: any options passed to the view
				-- icon_hl_group: optional hl_group for the icon
				-- title: set to anything or empty string to hide
				cmdline = { pattern = "^:", icon = ":", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = "?", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$", lang = "bash", title = "Shell" },
				-- lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "Lua", lang = "lua" },
				lua = false,
				--help = { pattern = "^:%s*he?l?p?%s+", icon = "Help" },
				help = false,
				input = { icon = ":" }, -- Used by input()
				-- lua = false, -- to disable a format, set to `false`
			},
		},
		messages = {
			-- NOTE: If you enable messages, then the cmdline is enabled automatically.
			-- This is a current Neovim limitation.
			enabled = false,    -- enables the Noice messages UI
			view = "notify",    -- default view for messages
			view_error = "notify", -- view for errors
			view_warn = "notify", -- view for warnings
			view_history = "messages", -- view for :messages
			view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
		},
		popupmenu = {
			enabled = true, -- enables the Noice popupmenu UI
			---@type 'nui'|'cmp'
			backend = "cmp", -- backend to use to show regular cmdline completions
			---@type NoicePopupmenuItemKind|false
			-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
			kind_icons = false, -- set to `false` to disable icons
		},
		-- default options for require('noice').redirect
		-- see the section on Command Redirection
		---@type NoiceRouteConfig
		redirect = {
			view = "popup",
			filter = { event = "msg_show" },
		},
		-- You can add any custom commands below that will be available with `:Noice command`
		---@type table<string, NoiceCommand>
		commands = {
			history = {
				-- options for the message history that you get with `:Noice`
				view = "split",
				opts = { enter = true, format = "details" },
				filter = {
					any = {
						{ event = "notify" },
						{ error = true },
						{ warning = true },
						{ event = "msg_show", kind = { "" } },
						{ event = "lsp",      kind = "message" },
					},
				},
			},
			-- :Noice last
			last = {
				view = "popup",
				opts = { enter = true, format = "details" },
				filter = {
					any = {
						{ event = "notify" },
						{ error = true },
						{ warning = true },
						{ event = "msg_show", kind = { "" } },
						{ event = "lsp",      kind = "message" },
					},
				},
				filter_opts = { count = 1 },
			},
			-- :Noice errors
			errors = {
				-- options for the message history that you get with `:Noice`
				view = "popup",
				opts = { enter = true, format = "details" },
				filter = { error = true },
				filter_opts = { reverse = true },
			},
		},
		notify = {
			-- Noice can be used as `vim.notify` so you can route any notification like other messages
			-- Notification messages have their level and other properties set.
			-- event is always "notify" and kind can be any log level as a string
			-- The default routes will forward notifications to nvim-notify
			-- Benefit of using Noice for this is the routing and consistent history view
			enabled = true,
			view = "notify",
		},
		lsp = {
			progress = {
				enabled = false,
				-- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
				-- See the section on formatting for more details on how to customize.
				--- @type NoiceFormat|string
				format = "lsp_progress",
				--- @type NoiceFormat|string
				format_done = "lsp_progress_done",
				throttle = 1000 / 30, -- frequency to update lsp progress message
				view = "mini",
			},
			override = {
				-- override the default lsp markdown formatter with Noice
				["vim.lsp.util.convert_input_to_markdown_lines"] = false,
				-- override the lsp markdown formatter with Noice
				["vim.lsp.util.stylize_markdown"] = false,
				-- override cmp documentation with Noice (needs the other options to work)
				--["cmp.entry.get_documentation"] = false,
			},
			hover = {
				enabled = true,
				silent = false, -- set to true to not show a message if hover is not available
				view = nil, -- when nil, use defaults from documentation
				---@type NoiceViewOptions
				opts = {}, -- merged with defaults from documentation
			},
			signature = {
				enabled = true,
				auto_open = {
					enabled = false,
					trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
					luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
					throttle = 50, -- Debounce lsp signature help request by 50ms
				},
				view = nil, -- when nil, use defaults from documentation
				---@type NoiceViewOptions
				opts = {}, -- merged with defaults from documentation
			},
			message = {
				-- Messages shown by lsp servers
				enabled = true,
				view = "notify",
				opts = {},
			},
			-- defaults for hover and signature help
			documentation = {
				view = "hover",
				---@type NoiceViewOptions
				opts = {
					lang = "markdown",
					replace = true,
					render = "plain",
					format = { "{message}" },
					win_options = { concealcursor = "n", conceallevel = 3 },
				},
			},
		},
		health = {
			checker = true, -- Disable if you don't want health checks to run
		},
		smart_move = {
			-- noice tries to move out of the way of existing floating windows.
			enabled = true, -- you can disable this behaviour here
			-- add any filetypes here, that shouldn't trigger smart move.
			excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
		},
		---@type NoicePresets
		presets = {
			-- you can enable a preset by setting it to true, or a table that will override the preset config
			-- you can also add custom presets that you can enable/disable with enabled=true
			bottom_search = false, -- use a classic bottom cmdline for search
			command_palette = false, -- position the cmdline and popupmenu together
			long_message_to_split = false, -- long messages will be sent to a split
			inc_rename = false,   -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
		throttle = 1000 / 30,     -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
		---@type NoiceConfigViews
		views = {}, ---@see section on views
		---@type NoiceRouteConfig[]
		routes = {}, --- @see section on routes
		---@type table<string, NoiceFilter>
		status = {}, --- @see section on statusline components
		---@type NoiceFormatOptions
		format = {}, --- @see section on formatting
	}
}, {
	"rcarriga/nvim-notify",
	lazy = true,
	-- event = 'VeryLazy',
	opts = {
		background_colour = "NotifyBackground",
		fps = 30,
		icons = {
			DEBUG = "DEBUG",
			ERROR = "ERROR",
			INFO = "INFO",
			TRACE = "TRACE",
			WARN = "WARN"
		},
		level = 2,
		minimum_width = 50,
		render = "default",
		stages = "fade_in_slide_out",
		time_formats = {
			notification = "%T",
			notification_history = "%FT%T"
		},
		timeout = 5000,
		top_down = true
	}
}, {
	"X3eRo0/dired.nvim",
	opts = {
		show_icons = false,
		keybinds = {
			dired_create = "o",
			dired_mark = ",",
			dired_toggle_sort_order = nil,
		}
	},
	init = function()
		vim.keymap.set("n", ";D", ":Dired<CR>", { silent = true, noremap = true })
	end,
	cmd = "Dired"
}, {
	"stevearc/aerial.nvim",
	opts = {
		-- Priority list of preferred backends for aerial.
		-- This can be a filetype map (see :help aerial-filetype-map)
		backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },

		layout = {
			-- These control the width of the aerial window.
			-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_width and max_width can be a list of mixed types.
			-- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
			max_width = { 60, 0.25 },
			width = nil,
			min_width = 10,

			-- key-value pairs of window-local options for aerial window (e.g. winhl)
			win_opts = {},

			-- Determines the default direction to open the aerial window. The 'prefer'
			-- options will open the window in the other direction *if* there is a
			-- different buffer in the way of the preferred direction
			-- Enum: prefer_right, prefer_left, right, left, float
			default_direction = "prefer_left",

			-- Determines where the aerial window will be opened
			--   edge   - open aerial at the far right/left of the editor
			--   window - open aerial to the right/left of the current window
			placement = "window",

			-- When the symbols change, resize the aerial window (within min/max constraints) to fit
			resize_to_content = true,

			-- Preserve window size equality with (:help CTRL-W_=)
			preserve_equality = false,
		},

		-- Determines how the aerial window decides which buffer to display symbols for
		--   window - aerial window will display symbols for the buffer in the window from which it was opened
		--   global - aerial window will display symbols for the current window
		attach_mode = "window",

		-- List of enum values that configure when to auto-close the aerial window
		--   unfocus       - close aerial when you leave the original source window
		--   switch_buffer - close aerial when you change buffers in the source window
		--   unsupported   - close aerial when attaching to a buffer that has no symbol source
		close_automatic_events = {},

		-- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
		-- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
		-- Additionally, if it is a string that matches "actions.<name>",
		-- it will use the mapping at require("aerial.actions").<name>
		-- Set to `false` to remove a keymap
		keymaps = {
			-- With autojump=true, most keys are useless
			["?"] = "actions.show_help",
			["<CR>"] = "actions.jump",
			["<2-LeftMouse>"] = "actions.jump",
			["<C-v>"] = "actions.jump_vsplit",
			-- ["p"] = "actions.scroll",
			-- ["<C-j>"] = "actions.down_and_scroll",
			-- ["<C-k>"] = "actions.up_and_scroll",
			["{"] = "actions.prev",
			["}"] = "actions.next",
			-- ["[["] = "actions.prev_up",
			-- ["]]"] = "actions.next_up",
			["q"] = "actions.close",
			["o"] = "actions.tree_toggle",
			["l"] = "actions.tree_open",
			["h"] = "actions.tree_close",
		},

		-- When true, don't load aerial until a command or function is called
		-- Defaults to true, unless `on_attach` is provided, then it defaults to false
		lazy_load = true,

		-- Disable aerial on files with this many lines
		disable_max_lines = 10000,

		-- Disable aerial on files this size or larger (in bytes)
		disable_max_size = 2000000, -- Default 2MB

		-- A list of all symbols to display. Set to false to display all symbols.
		-- This can be a filetype map (see :help aerial-filetype-map)
		-- To see all available values, see :help SymbolKind
		filter_kind = {
			"Class",
			"Constructor",
			"Enum",
			"Function",
			"Interface",
			"Module",
			"Method",
			"Struct",
		},

		-- Determines line highlighting mode when multiple splits are visible.
		-- split_width   Each open window will have its cursor location marked in the
		--               aerial buffer. Each line will only be partially highlighted
		--               to indicate which window is at that location.
		-- full_width    Each open window will have its cursor location marked as a
		--               full-width highlight in the aerial buffer.
		-- last          Only the most-recently focused window will have its location
		--               marked in the aerial buffer.
		-- none          Do not show the cursor locations in the aerial window.
		highlight_mode = "split_width",

		-- Highlight the closest symbol if the cursor is not exactly on one.
		highlight_closest = true,

		-- Highlight the symbol in the source buffer when cursor is in the aerial win
		highlight_on_hover = false,

		-- When jumping to a symbol, highlight the line for this many ms.
		-- Set to false to disable
		highlight_on_jump = 300,

		-- Jump to symbol in source window when the cursor moves
		autojump = true,

		-- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
		-- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
		-- default collapsed icon. The default icon set is determined by the
		-- "nerd_font" option below.
		-- If you have lspkind-nvim installed, it will be the default icon set.
		-- This can be a filetype map (see :help aerial-filetype-map)
		icons = {},

		-- Control which windows and buffers aerial should ignore.
		-- Aerial will not open when these are focused, and existing aerial windows will not be updated
		ignore = {
			-- Ignore unlisted buffers. See :help buflisted
			unlisted_buffers = false,

			-- Ignore diff windows (setting to false will allow aerial in diff windows)
			diff_windows = true,

			-- List of filetypes to ignore.
			filetypes = {},

			-- Ignored buftypes.
			-- Can be one of the following:
			-- false or nil - No buftypes are ignored.
			-- "special"    - All buffers other than normal, help and man page buffers are ignored.
			-- table        - A list of buftypes to ignore. See :help buftype for the
			--                possible values.
			-- function     - A function that returns true if the buffer should be
			--                ignored or false if it should not be ignored.
			--                Takes two arguments, `bufnr` and `buftype`.
			buftypes = "special",

			-- Ignored wintypes.
			-- Can be one of the following:
			-- false or nil - No wintypes are ignored.
			-- "special"    - All windows other than normal windows are ignored.
			-- table        - A list of wintypes to ignore. See :help win_gettype() for the
			--                possible values.
			-- function     - A function that returns true if the window should be
			--                ignored or false if it should not be ignored.
			--                Takes two arguments, `winid` and `wintype`.
			wintypes = "special",
		},

		-- Use symbol tree for folding. Set to true or false to enable/disable
		-- Set to "auto" to manage folds if your previous foldmethod was 'manual'
		-- This can be a filetype map (see :help aerial-filetype-map)
		manage_folds = false,

		-- When you fold code with za, zo, or zc, update the aerial tree as well.
		-- Only works when manage_folds = true
		link_folds_to_tree = false,

		-- Fold code when you open/collapse symbols in the tree.
		-- Only works when manage_folds = true
		link_tree_to_folds = true,

		-- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
		-- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
		nerd_font = false,

		-- When true, aerial will automatically close after jumping to a symbol
		close_on_select = true,

		-- The autocmds that trigger symbols update (not used for LSP backend)
		update_events = "TextChanged,InsertLeave",

		-- Show box drawing characters for the tree hierarchy
		show_guides = true,

		-- Customize the characters used when show_guides = true
		guides = {
			-- When the child item has a sibling below it
			mid_item = "├─",
			-- When the child item is the last in the list
			last_item = "└─",
			-- When there are nested child guides to the right
			nested_top = "│ ",
			-- Raw indentation
			whitespace = "  ",
		},

		lsp = {
			-- If true, fetch document symbols when LSP diagnostics update.
			diagnostics_trigger_update = false,

			-- Set to false to not update the symbols when there are LSP errors
			update_when_errors = true,

			-- How long to wait (in ms) after a buffer change before updating
			-- Only used when diagnostics_trigger_update = false
			update_delay = 300,

			-- Map of LSP client name to priority. Default value is 10.
			-- Clients with higher (larger) priority will be used before those with lower priority.
			-- Set to -1 to never use the client.
			priority = {
				-- pyright = 10,
			},
		},
	},
	init = function()
		vim.keymap.set('n', '<leader>a', ':AerialToggle<CR>', { noremap = true, silent = true })
	end,
	cmd = "AerialToggle"
}, {
	"simeji/winresizer",
	event = 'VeryLazy',
	init = function()
		vim.g.winresizer_start_key = '<leader>r'
	end,
}, {
	"stevearc/dressing.nvim",
	event = 'VeryLazy',
}, {
	"jeetsukumaran/vim-buffergator",
	init = function()
		vim.g.buffergator_suppress_keymaps = 1
		vim.keymap.set('n', '<leader>b', ':BuffergatorOpen<CR>', { noremap = true, silent = true })
	end,
	cmd = "BuffergatorOpen"
}, {
	"dzfrias/arena.nvim",
	opts = {
		-- Maxiumum number of files that the arena window can contain, or `nil` for
		-- an unlimited amount
		max_items = 5,
		-- Always show the enclosing directory for these paths
		always_context = { "mod.rs", "init.lua" },
		-- When set, ignores the current buffer when listing files in the window.
		ignore_current = false,
		-- Options to apply to the arena buffer.
		buf_opts = {
			-- ["relativenumber"] = false,
		},
		-- Filter out buffers per the project they belong to.
		per_project = false,
		--- Add devicons (from nvim-web-devicons, if installed) to buffers
		devicons = false,


		window = {
			width = 60,
			height = 10,
			border = "rounded",

			-- Options to apply to the arena window.
			opts = {},
		},

		-- Keybinds for the arena window.
		keybinds = {
			-- ["e"] = function()
			--   vim.cmd("echo \"Hello from the arena!\"")
			-- end
		},

		-- Change the way the arena listing looks with custom rendering functions
		renderers = {},

		-- Config for frecency algorithm.
		algorithm = {
			-- Multiplies the recency by a factor. Must be greater than zero.
			-- A smaller number will mean less of an emphasis on recency!
			recency_factor = 0.5,
			-- Same as `recency_factor`, but for frequency!
			frequency_factor = 1,
		},
	},
	init = function()
		vim.keymap.set('n', '<leader>B', ':ArenaToggle<CR>', { noremap = true, silent = true })
	end,
	cmd = "ArenaToggle"
} }
