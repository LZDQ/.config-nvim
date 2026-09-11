return { {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- Auto install, start() and indent implemented by GPT
		local ts = require("nvim-treesitter")

		local available = {}
		for _, lang in ipairs(ts.get_available()) do
			available[lang] = true
		end

		local indent = {
			javascript = true,
			javascriptreact = true,
			typescript = true,
			typescriptreact = true,
		}

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if not lang or not available[lang] then
					return
				end

				if indent[args.match] then
					vim.bo[args.buf].indentexpr =
						"v:lua.require'nvim-treesitter'.indentexpr()"
				end

				ts.install({ lang }):await(function(err, ok)
					if err or not ok or not vim.api.nvim_buf_is_valid(args.buf) then
						return
					end

					pcall(vim.treesitter.start, args.buf, lang)
				end)
			end,
		})
	end,
}, {
	"nvim-treesitter/nvim-treesitter-context",
	event = 'VeryLazy',
	opts = {
		enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		-- multiwindow = false,    -- Enable multiwindow support.
		max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
		-- min_window_height = 0,  -- Minimum editor window height to enable context. Values <= 0 mean no limit.
		line_numbers = false,
	}
}, {
	"nvim-treesitter/nvim-treesitter-textobjects",
	event = 'VeryLazy',
	config = function()
		require("nvim-treesitter-textobjects").setup {
			select = {
				lookahead = false,
				selection_modes = {
					["@parameter.inner"] = "v",
					["@function.outer"] = "V",
					["@function.inner"] = "V",
					["@class.outer"] = "V",
					["@class.inner"] = "V",
					["@loop.inner"] = "V",
					["@loop.outer"] = "V",
				},
				include_surrounding_whitespace = false,
			},
			move = {
				set_jumps = true,
			},
		}
		local keymaps = {
			-- NOTE: if treesitter is not installed for the current filetype, it will error
			select = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aC"] = "@class.outer",
				["iC"] = "@class.inner",
				["i,"] = "@parameter.inner",
				["a,"] = "@parameter.outer",
				["ic"] = "@comment.inner",
				["ac"] = "@comment.outer",
				["il"] = "@loop.inner",
				["al"] = "@loop.outer",
				["in"] = "@number.inner",
				["ia"] = "@attribute.inner",
				["aa"] = "@attribute.outer",
			},
			swap_next = {
				["g>"] = "@parameter.inner",
			},
			swap_previous = {
				["g<lt>"] = "@parameter.inner",
			},
			goto_next_start = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
				["]i"] = "@conditional.outer",
				[")"] = "@parameter.inner",
				["]l"] = "@loop.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
				["]L"] = "@loop.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
				["[i"] = "@conditional.outer",
				["("] = "@parameter.inner",
				["[l"] = "@loop.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
				["[L"] = "@loop.outer",
			},
			goto_next = {
			},
			goto_previous = {
			},
		}
		local select = require("nvim-treesitter-textobjects.select")
		local swap = require("nvim-treesitter-textobjects.swap")
		local move = require("nvim-treesitter-textobjects.move")
		local opts = { silent = true }

		for lhs, capture in pairs(keymaps.select) do
			vim.keymap.set({ "x", "o" }, lhs, function()
				select.select_textobject(capture)
			end, opts)
		end

		for lhs, capture in pairs(keymaps.swap_next) do
			vim.keymap.set("n", lhs, function()
				swap.swap_next(capture)
			end, opts)
		end

		for lhs, capture in pairs(keymaps.swap_previous) do
			vim.keymap.set("n", lhs, function()
				swap.swap_previous(capture)
			end, opts)
		end

		for lhs, capture in pairs(keymaps.goto_next_start) do
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move.goto_next_start(capture)
			end, opts)
		end

		for lhs, capture in pairs(keymaps.goto_next_end) do
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move.goto_next_end(capture)
			end, opts)
		end

		for lhs, capture in pairs(keymaps.goto_previous_start) do
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move.goto_previous_start(capture)
			end, opts)
		end

		for lhs, capture in pairs(keymaps.goto_previous_end) do
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move.goto_previous_end(capture)
			end, opts)
		end

		for lhs, capture in pairs(keymaps.goto_next) do
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move.goto_next(capture)
			end, opts)
		end

		for lhs, capture in pairs(keymaps.goto_previous) do
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move.goto_previous(capture)
			end, opts)
		end
	end
} }
