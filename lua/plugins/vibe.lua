return { {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = vim.fn.has("win32") ~= 0
	and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
	or "make",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	---@module 'avante'
	---@type avante.Config
	opts = {
		-- add any opts here
		-- this file can contain specific instructions for your project
		instructions_file = "avante.md",
		-- for example
		provider = "openrouter",
		providers = {
			openrouter = {
				__inherited_from = 'openai',
				endpoint = 'https://openrouter.ai/api/v1',
				api_key_name = 'OPENROUTER_API_KEY',
				model = 'google/gemini-2.5-pro',
			},
		},
		mappings = {
			--- @class AvanteConflictMappings
			diff = {
				ours = "ch", -- Choose HEAD (ours)
				-- theirs = "ct",
				-- all_theirs = "ca",
				-- both = "cb",
				-- cursor = "cc",
				-- next = "]x",
				-- prev = "[x",
			},
			sidebar = {
				next_prompt = "p",
				prev_prompt = "P",
			}
		},
		behaviour = {
			auto_apply_diff_after_generation = false,
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		-- "nvim-mini/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"stevearc/dressing.nvim", -- for input provider dressing
		-- "zbirenbaum/copilot.lua", -- for providers='copilot'
		"hakonharnes/img-clip.nvim", -- support for image pasting
		{
			-- Make sure to set this up properly if you have lazy=true
			'MeanderingProgrammer/render-markdown.nvim',
			opts = {
				file_types = { "markdown", "Avante" },
				heading = {
					atx = false, -- disable heading icons
					-- setext = false,
					-- sign = false,
				},
				checkbox = {
					unchecked = {
						icon = '[ ]'
					},
					checked = {
						icon = '[x]'
					},
				},
				sign = { enabled = false }
			},
			ft = { "markdown", "Avante" },
		},
	},
} }
