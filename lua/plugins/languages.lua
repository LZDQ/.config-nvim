local keymap_opts = { noremap = true, buffer = 0 }
return {
	-- lua
	{
		"folke/lazydev.nvim",
		ft = 'lua',
	},
	{
		"milisims/nvim-luaref",
		ft = "lua",
	},
	-- python
	{
		"roobert/f-string-toggle.nvim",
		ft = "python",
		opts = {},
	} , {
		"jeetsukumaran/vim-pythonsense",
		ft = "python",
		init = function()
			vim.g.is_pythonsense_suppress_keymaps = 1
		end,
		config = function()
			vim.keymap.set({ "v", "o" }, 'ad', '<Plug>(PythonsenseOuterDocStringTextObject)', keymap_opts)
			vim.keymap.set({ "v", "o" }, 'id', '<Plug>(PythonsenseInnerDocStringTextObject)', keymap_opts)
		end
	}, {
		"Vimjas/vim-python-pep8-indent",
		ft = "python",
	}, {
		"benlubas/molten-nvim",
		enabled = true,
		-- ft = "python",
		build = ':UpdateRemotePlugins',
		cmd = "MoltenInit",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "python",
				callback = function()
					vim.keymap.set("n", "mi", "<CMD>MoltenInit<CR>", keymap_opts) -- Initialize the plugin
				end,
			})
		end,
		config = function()
			-- Interactive python
			-- Note: share the prefix 'm' with vim-bookmarks
			vim.keymap.set("n", "me", "<CMD>MoltenEvaluateOperator<CR>", keymap_opts) -- run operator selection
			vim.keymap.set("n", "ml", "<CMD>MoltenEvaluateLine<CR>", keymap_opts) -- evaluate line
			vim.keymap.set("n", "mr", "<CMD>MoltenReevaluateCell<CR>", keymap_opts) -- re-evaluate cell
			vim.keymap.set("v", "m", "<CMD><C-u>MoltenEvaluateVisual<CR>", keymap_opts) -- evaluate visual selection
			vim.keymap.set("n", "md", "<CMD>MoltenDelete<CR>", keymap_opts)    -- delete current cell
			vim.keymap.set("n", "mh", "<CMD>MoltenHideOutput<CR>", keymap_opts) -- hide output of current cell
		end
	},
	-- yaml
	{
		"cuducos/yaml.nvim",
		ft = "yaml",
		dependencies = { "nvim-lualine/lualine.nvim" },
		config = function()
			local yaml = require("yaml_nvim")
			yaml.setup {}

			-- TODO: make it not conflict with current settings
			-- require('lualine').setup {
			-- 	sections = {
			-- 		lualine_c = { 'filename', yaml.get_yaml_key }
			-- 	}
			-- }
		end
	},
	-- java
	-- {
	-- 	"mfussenegger/nvim-jdtls", -- This doesn't setup references, using nvim-java instead.
	-- 	ft = "java",
	-- 	config = function()
	-- 		require('jdtls').start_or_attach {
	-- 			cmd = { 'jdtls' },
	-- 			root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
	-- 		}
	-- 	end
	-- },
	-- {
	-- 	"nvim-java/nvim-java",
	-- 	ft = "java",
	-- 	-- version = '3.0.0',
	-- 	config = function ()
	-- 		-- vim.notify("fuck1")
	-- 		require('java').setup({
	-- 			java_test = {
	-- 				enable = false,
	-- 				version = '0.43.1'  -- This is a TEMPORARY solution to install java-test
	-- 			},
	-- 			-- java_debug_adapter = { enable = false },
	-- 			spring_boot_tools = { enable = false },
	-- 			-- lombok = { enable = false },
	-- 		})
	-- 		-- vim.notify("fuck2")
	-- 		vim.lsp.enable('jdtls')
	-- 	end,
	-- 	-- dependencies = {
	-- 	-- 	"mason-org/mason.nvim",
	-- 	-- },
	-- },
	-- csv
	{
		"hat0uma/csvview.nvim",
		ft = "csv",
		config = function()
			local csvview = require('csvview')
			csvview.setup {}
			csvview.enable()
		end
	},
	-- rust
	{
		"rust-lang/rust.vim",
		ft = "rust",
		-- TODO: any setup
	},
	-- tex
	{
		"lervag/vimtex",
		-- ft = "tex", -- The doc says it is already lazy loaded
		lazy = false,
	},
	-- scala
	{
		"scalameta/nvim-metals",
		ft = "scala",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = function()
			-- local fn = vim.fn
			local metals_config = require("metals").bare_config()

			-- Example of settings
			metals_config.settings = {
				-- autoImportBuild = "all",
				showImplicitArguments = true,
				-- excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
				showInferredType = true,
				superMethodLensesEnabled = true,
				showImplicitConversionsAndClasses = true,
				verboseCompilation = true,
			}

			-- *READ THIS*
			-- I *highly* recommend setting statusBarProvider to either "off" or "on"
			--
			-- "off" will enable LSP progress notifications by Metals and you'll need
			-- to ensure you have a plugin like fidget.nvim installed to handle them.
			--
			-- "on" will enable the custom Metals status extension and you *have* to have
			-- a have settings to capture this in your statusline or else you'll not see
			-- any messages from metals. There is more info in the help docs about this
			metals_config.init_options.statusBarProvider = "off"

			-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
			metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- metals_config.on_attach = function(client, bufnr)
			-- 	-- require("metals").setup_dap()
			--
			-- 	-- LSP mappings
			-- 	map("n", "gD", vim.lsp.buf.definition)
			-- 	map("n", "K", vim.lsp.buf.hover)
			-- 	map("n", "gi", vim.lsp.buf.implementation)
			-- 	map("n", "gr", vim.lsp.buf.references)
			-- 	map("n", "gds", vim.lsp.buf.document_symbol)
			-- 	map("n", "gws", vim.lsp.buf.workspace_symbol)
			-- 	map("n", "<leader>cl", vim.lsp.codelens.run)
			-- 	map("n", "<leader>sh", vim.lsp.buf.signature_help)
			-- 	map("n", "<leader>rn", vim.lsp.buf.rename)
			-- 	map("n", "<leader>f", vim.lsp.buf.format)
			-- 	map("n", "<leader>ca", vim.lsp.buf.code_action)
			--
			-- 	map("n", "<leader>ws", function()
			-- 		require("metals").hover_worksheet()
			-- 	end)
			--
			-- -- all workspace diagnostics
			-- map("n", "<leader>aa", vim.diagnostic.setqflist)
			--
			-- -- all workspace errors
			-- map("n", "<leader>ae", function()
			-- 	vim.diagnostic.setqflist({ severity = "E" })
			-- end)
			--
			-- -- all workspace warnings
			-- map("n", "<leader>aw", function()
			-- 	vim.diagnostic.setqflist({ severity = "W" })
			-- end)
			--
			-- 	-- buffer diagnostics only
			-- 	map("n", "<leader>d", vim.diagnostic.setloclist)
			--
			-- 	map("n", "[c", function()
			-- 		vim.diagnostic.goto_prev({ wrap = false })
			-- 	end)
			--
			-- 	map("n", "]c", function()
			-- 		vim.diagnostic.goto_next({ wrap = false })
			-- 	end)
			--
			-- 	-- Example mappings for usage with nvim-dap. If you don't use that, you can
			-- 	-- skip these
			-- 	map("n", "<leader>dc", function()
			-- 		require("dap").continue()
			-- 	end)
			--
			-- 	map("n", "<leader>dr", function()
			-- 		require("dap").repl.toggle()
			-- 	end)
			--
			-- 	map("n", "<leader>dK", function()
			-- 		require("dap.ui.widgets").hover()
			-- 	end)
			--
			-- 	map("n", "<leader>dt", function()
			-- 		require("dap").toggle_breakpoint()
			-- 	end)
			--
			-- 	map("n", "<leader>dso", function()
			-- 		require("dap").step_over()
			-- 	end)
			--
			-- 	map("n", "<leader>dsi", function()
			-- 		require("dap").step_into()
			-- 	end)
			--
			-- 	map("n", "<leader>dl", function()
			-- 		require("dap").run_last()
			-- 	end)
			-- end

			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = self.ft,
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end
	},
}
