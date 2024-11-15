local overseer = require('overseer')
overseer.setup {
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
			run = function (task)
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
}

local function overseer_load_tasks(tasks)
	for name, task in pairs(tasks) do
		task.name = name
		overseer.register_template(task)
	end
end

--- Competitive programming

local tasks_cp = {
	compile = {
		desc = "Compile (with optional flags)",
		params = {
			use_O2 = {
				desc = "Enable optimization with -O2",
				type = "boolean",
				default = false,
			},
			debug = {
				desc = "Enable debug information with -g",
				type = "boolean",
				default = false,
			},
			std_version = {
				desc = "C++ standard version",
				type = "string",
				default = "c++17",
			},
		},
		builder = function(params)
			local args = {
				vim.fn.expand("%:t"),
				"-o",
				vim.fn.expand("%:r"),
				"-std=" .. params.std_version,
			}

			if params.use_O2 then
				table.insert(args, "-O2")
			end

			if params.debug then
				table.insert(args, "-g")
				table.insert(args, "-fsanitize=undefined,leak,address")
				table.insert(args, "-Wall")
			end
			return {
				cmd = { "g++" },
				args = args,
			}
		end,
		condition = { filetype = "cpp" },
	},
	run = {
		desc = "Run Executable",
		builder = function()
			return {
				cmd = { "./" .. vim.fn.expand("%:r") },
			}
		end,
		condition = { filetype = "cpp" },
	},
	cf_test = {
		desc = "CF Test",
		builder = function()
			return {
				cmd = { "cf" },
				args = { "test", vim.fn.expand("%:t") },
			}
		end,
		condition = { filetype = "cpp" },
	},
	cf_submit = {
		desc = "CF Submit",
		builder = function()
			return {
				cmd = { "cf" },
				args = { "submit", "-f", vim.fn.expand("%:t") },
			}
		end,
		condition = { filetype = "cpp" },
	},
}

local function cb_float(task)
	if task then
		overseer.run_action(task, 'open float')
	end
end


if vim.fn.getcwd():match("^/home/ldq/OI") ~= nil then
	overseer_load_tasks(tasks_cp)
	-- F9 to compile
	vim.keymap.set('n', '<F9>', function()
		vim.cmd("w")
		overseer.run_template({ name = "compile", prompt = "never" }, cb_float)
	end)
	-- A-F9 to compile with O2
	vim.keymap.set('n', '<F57>', function()
		vim.cmd("w")
		overseer.run_template({ name = "compile", params = { use_O2 = true }, prompt = "never" }, cb_float)
	end)
	-- C-F9 to compile with debug info and sanitize
	vim.keymap.set('n', '<F33>', function()
		vim.cmd("w")
		overseer.run_template({ name = "compile", params = { debug = true }, prompt = "never" }, cb_float)
	end)
	-- F10 to compile with debug info and sanitize
	vim.keymap.set('n', '<F10>', function() overseer.run_template({ name = "run" }, cb_float) end)
	-- F5 to test
	-- The plugin has a bug  https://github.com/stevearc/overseer.nvim/issues/300
	-- Waiting for the author to fix
	-- vim.keymap.set('n', '<F5>', function() overseer.run_template({ name = "cf_test" }, cb_float) end)
	vim.keymap.set('n', '<F5>', ':term cf test %<CR>', { silent = true })
	-- C-F5 to submit
	vim.keymap.set('n', '<F29>', function() overseer.run_template({ name = "cf_submit" }, cb_float) end)
end

require('lazydev').setup{}

