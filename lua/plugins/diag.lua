vim.diagnostic.config{
	jump = { 
		float = true
	},
	update_in_insert = false,
}

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.diagnostic.enable(false)
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
		vim.keymap.set('n', '[d', function () vim.diagnostic.jump{count=-1} end)
		vim.keymap.set('n', ']d', function () vim.diagnostic.jump{count=1} end)
	end
})

return {}
