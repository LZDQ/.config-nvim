return { {
	"nvim-focus/focus.nvim",
	opts = {
		-- split = { bufnew = false }
	},
	config = function (_, opts)
		require("focus").setup(opts)

		-- Disable focus for Overseer
		local ignore_filetypes = { 'OverseerList' }
		-- local ignore_buftypes = { 'nofile', 'prompt', 'popup' }

		local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })

		--[[ vim.api.nvim_create_autocmd('WinEnter', {
			group = augroup,
			callback = function(_)
				if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
					vim.w.focus_disable = true
				else
					vim.w.focus_disable = false
				end
			end,
			desc = 'Disable focus autoresize for BufType',
		}) ]]

		vim.api.nvim_create_autocmd('FileType', {
			group = augroup,
			callback = function(_)
				if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
					vim.b.focus_disable = true
				else
					vim.b.focus_disable = false
				end
			end,
			desc = 'Disable focus autoresize for FileType',
		})
	end,
	-- event = 'WinResized' -- conflicts with FileType
}, {
	"folke/zen-mode.nvim",
	init = function()
		vim.keymap.set('n', '<leader><leader><BS>', '<CMD>ZenMode<CR>')
	end,
	cmd = "ZenMode"
}, {
	"folke/twilight.nvim",
	cmd = { "Twilight", "TwilightEnable" }
}, {
	"LZDQ/nvim-autocenter",
	dev = false,
	event = 'InsertEnter',
	opts = {
		-- when = 'always'
	}
}, {
	"shortcuts/no-neck-pain.nvim",
	enabled = true,
	cmd = "NoNeckPain",
	opts = {
		-- width = "textwidth",
		width = 80;
	},
	init = function()
		-- TODO: change focus.nvim setup to avoid conflict with NoNeckPain
		vim.keymap.set('n', '<leader><BS>', '<Cmd>FocusToggle<CR><Cmd>NoNeckPain<CR>')
		vim.keymap.set('n', '<leader>+', '<Cmd>NoNeckPainWidthUp<CR>')
		vim.keymap.set('n', '<leader>-', '<Cmd>NoNeckPainWidthDown<CR>')
	end
} }
