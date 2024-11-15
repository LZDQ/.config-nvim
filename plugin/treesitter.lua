require('nvim-treesitter.configs').setup {
	-- A directory to install the parsers into.
	-- If this is excluded or nil parsers are installed
	-- to either the package dir, or the "site" dir.
	-- If a custom path is used (not nil) it must be added to the runtimepath.
	-- parser_install_dir = "/some/path/to/store/parsers",

	-- A list of parser names, or "all"
	ensure_installed = { "c", "lua", "python" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = true,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	-- ignore_install = { "javascript" },

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- list of language that will be disabled
		disable = {},

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

	textobjects = {
		-- Configs for select, swap, jump
		select = {
			enable = true,
			lookahead = false,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["i,"] = "@parameter.inner",
				["a,"] = "@parameter.outer",
				-- [","] = "@parameter.inner",
			},
			selection_modes = {
				['@parameter.inner'] = 'v', -- charwise
				['@function.outer'] = 'V', -- linewise
				['@function.inner'] = 'V', -- linewise
				['@class.outer'] = 'V', -- linewise
				['@class.inner'] = 'V', -- linewise
			},
			include_surrounding_whitespace = false,
		},

		swap = {
			enable = true,
			swap_next = {
				["g>"] = "@parameter.inner",
			},
			swap_previous = {
				["g<"] = "@parameter.inner",
			},
		},

		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
				--
				-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
				--["]o"] = "@loop.*",
				-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
				--
				-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
				-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
				-- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
				--["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
				[")"] = "@parameter.inner",
			},
			goto_next_end = {
				-- ["]F"] = "@function.outer",
				-- ["]C"] = "@class.outer",
			},
			goto_previous_start = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
				["("] = "@parameter.inner",
			},
			goto_previous_end = {
				-- ["[F"] = "@function.outer",
				-- ["[C"] = "@class.outer",
			},
			-- Below will go to either the start or the end, whichever is closer.
			-- Use if you want more granular movements
			-- Make it even more gradual by adding multiple queries and regex.
			goto_next = {
				["]i"] = "@conditional.outer",
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
			},
			goto_previous = {
				["[i"] = "@conditional.outer",
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
			},
		},
	},
}
