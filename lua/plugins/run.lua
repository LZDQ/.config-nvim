return { {
	"stevearc/overseer.nvim",
	opts = {
		component_aliases = {
			default = {
				{ "display_duration", detail_level = 2 },
				-- "on_output_summarize",
				"on_exit_set_status",
				--"on_complete_notify",
				-- "on_complete_dispose",
				-- "open_output",
			},
		},
		actions = {
			["run"] = {
				desc = "Just run",
				run = function(task)
					if task.status == require("overseer.constants").STATUS.PENDING then
						task:start()
					else
						task:restart(true)
					end
				end
			}
		},
		task_list = {
			bindings = {
				["r"] = "<CMD>OverseerQuickAction run<CR>",
				["D"] = "<CMD>OverseerQuickAction dispose<CR>",
				["E"] = "<CMD>OverseerQuickAction edit<CR>",
				["s"] = "<CMD>OverseerQuickAction stop<CR>",
			}
		},
	},
	config = function(_, opts)
		local overseer = require('overseer')
		overseer.setup(opts)
		vim.keymap.set('n', "'", overseer.toggle)
		vim.keymap.set('n', ";r", overseer.run_template)
	end
} }
