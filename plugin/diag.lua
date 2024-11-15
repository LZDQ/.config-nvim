vim.diagnostic.disable()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		-- Disable signs
		signs = false,
		-- Disable virtual text
		virtual_text = false,
		-- Keep the update in insert mode
		update_in_insert = false,
		-- Show diagnostics in the quickfix window
		severity_sort = true,
	}
)
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<F2>', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
