local keymap_opts = { noremap = true, silent = true, buffer = 0 }
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
		"jeetsukumaran/vim-pythonsense",
		ft = "python",
		init = function()
			vim.g.is_pythonsense_suppress_keymaps = 1
		end,
		config = function()
			vim.keymap.set({ "v", "o" }, 'ad', '<Plug>(PythonsenseOuterDocStringTextObject)', keymap_opts)
			vim.keymap.set({ "v", "o" }, 'id', '<Plug>(PythonsenseInnerDocStringTextObject)', keymap_opts)
		end
	},
	{
		"benlubas/molten-nvim",
		enabled = true,
		-- ft = "python",
		build = ':UpdateRemotePlugins',
		cmd = "MoltenInit",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "python",
				callback = function()
					vim.keymap.set("n", "mi", ":MoltenInit<CR>", keymap_opts) -- Initialize the plugin
				end,
			})
		end,
		config = function()
			-- Interactive python
			-- Note: share the prefix 'm' with vim-bookmarks
			vim.keymap.set("n", "me", ":MoltenEvaluateOperator<CR>", keymap_opts) -- run operator selection
			vim.keymap.set("n", "ml", ":MoltenEvaluateLine<CR>", keymap_opts) -- evaluate line
			vim.keymap.set("n", "mr", ":MoltenReevaluateCell<CR>", keymap_opts) -- re-evaluate cell
			vim.keymap.set("v", "m", ":<C-u>MoltenEvaluateVisual<CR>", keymap_opts) -- evaluate visual selection
			vim.keymap.set("n", "md", ":MoltenDelete<CR>", keymap_opts)    -- delete current cell
			vim.keymap.set("n", "mh", ":MoltenHideOutput<CR>", keymap_opts) -- hide output of current cell
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

			require('lualine').setup {
				sections = {
					lualine_c = { 'filename', yaml.get_yaml_key }
				}
			}
		end
	},
	-- java
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		config = function()
			require('jdtls').start_or_attach {
				cmd = { 'jdtls' },
				root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
			}
		end
	},
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
}
