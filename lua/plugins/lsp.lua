return { {
	"neovim/nvim-lspconfig",
	-- event = 'VeryLazy',
	config = function()
		-- Configuration at https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		-- local lspconfig = require('lspconfig')

		-- npm install -g pyright
		vim.notify("fuck lsp")
		vim.lsp.config("pyright", {
			cmd = { "pyright-langserver", "--stdio" }, -- Use stdio communication
			autostart = true,
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = 'openFilesOnly',
						useLibraryCodeForTypes = true,
						typeCheckingMode = 'off',
						reportMissingImports = true,
					}
				}
			},
		})
		-- pip install python-lsp-server
		-- lspconfig.pylsp.setup{}
		-- pip install pylyzer
		-- lspconfig.pylyzer.setup{}



		vim.lsp.config("clangd", {
			autostart = true,
			cmd = {
				"clangd",
				"--fallback-style=webkit"
			}
		})
		-- Assembly support   https://github.com/bergercookie/asm-lsp
		-- For RISC-V, use the following .asm-lsp.toml
		--
		-- version = "0.1"
		--
		-- [assemblers]
		-- gas = true
		-- go = false
		-- z80 = false
		-- masm = false
		-- nasm = false
		--
		-- [instruction_sets]
		-- x86 = false
		-- x86_64 = false
		-- z80 = false
		-- arm = false
		-- riscv = true
		--
		-- [opts]
		-- compiler = "riscv64-unknown-elf-gcc"
		-- diagnostics = true
		-- default_diagnostics = true

		-- vim.lsp.enable('asm_lsp')

		-- pip install jedi-language-server
		-- lspconfig.jedi_language_server.setup {}

		-- https://luals.github.io/#neovim-install
		-- or sudo pacman -S lua-language-server
		vim.lsp.config("lua_ls", {
			autostart = true,
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most commonly LuaJIT in the case of Neovim)
						version = 'LuaJIT',
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						-- globals = {'vim'},
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		})

		-- npm install -g --save-dev --save-exact @biomejs/biome
		-- lspconfig.biome.setup{}

		-- npm i vscode-langservers-extracted
		vim.lsp.enable("html")
		vim.lsp.enable("cssls")
		vim.lsp.enable("jsonls")
		-- lspconfig.eslint.setup { root_dir = lspconfig.util.root_pattern('.git', 'package.json', '.eslintrc.json', '.eslintrc.js'), }
		-- npm install -g typescript-language-server
		-- lspconfig.ts_ls.setup {} -- subset of typescript-tools.nvim

		-- npm install -g dockerfile-language-server-nodejs
		vim.lsp.enable("dockerls")

		-- npm install -g @microsoft/compose-language-service
		vim.lsp.enable("docker_compose_language_service")

		-- npm install -g --save-dev @babel/core @babel/cli @babel/preset-flow babel-plugin-syntax-hermes-parser
		-- lspconfig.flow.setup{}

		vim.lsp.enable("marksman")

		-- cargo install neocmakelsp
		-- lspconfig.neocmake.setup{}

		-- npm install -g vim-language-server
		vim.lsp.enable("vimls")

		-- npm i -g sql-language-server
		vim.lsp.enable("sqlls")

		-- npm install -g vls
		vim.lsp.enable("vls")

		-- npm i -g bash-language-server
		vim.lsp.enable("bashls")

		-- sudo pacman -S rust-analyzer
		vim.lsp.enable("rust_analyzer")

		-- dotnet tool install --global csharp-ls
		vim.lsp.enable("csharp_ls")
		-- lspconfig.omnisharp.setup{
		-- 	cmd ={ "/usr/bin/OmniSharp", "--languageserver" , "--hostPID", tostring(vim.fn.getpid()) },
		-- }

		-- go install github.com/nametake/golangci-lint-langserver@latest
		-- go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
		vim.lsp.enable("golangci_lint_ls")

		-- go install golang.org/x/tools/gopls@latest
		vim.lsp.enable("gopls")

		-- https://github.com/latex-lsp/texlab
		-- brew install texlab
		-- cargo install --git https://github.com/latex-lsp/texlab
		vim.lsp.enable("texlab")

		-- https://github.com/arduino/arduino-language-server
		-- go install github.com/arduino/arduino-language-server@latest
		-- Config at https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#arduino_language_server
		vim.lsp.enable("arduino_language_server")

		-- https://github.com/regen100/cmake-language-server
		-- AUR cmake-language-server
		vim.lsp.enable('cmake')

		vim.lsp.enable('jdtls')

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				-- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				-- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
				-- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
				-- vim.keymap.set('n', '<leader>wl', function()
				-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				-- end, opts)
				--vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
				vim.keymap.set('n', '<F18>', vim.lsp.buf.rename, opts) -- Shift + F6
				--vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', 'gR', vim.lsp.buf.references, opts)
				-- Format current line
				vim.keymap.set('n', '<leader>=', function()
					local line = vim.api.nvim_win_get_cursor(0)[1]
					vim.lsp.buf.format({
						range = {
							['start'] = { line, 0 },
							['end'] = { line, 0 },
						}
					})
				end, opts)
				-- Format visual selection
				vim.keymap.set('v', '<leader>=', function()
					vim.lsp.buf.format()
					vim.api.nvim_input('<ESC>')
				end, opts)
				vim.keymap.set('n', 'g=', vim.lsp.buf.format, opts)
			end
		})
	end
} }
