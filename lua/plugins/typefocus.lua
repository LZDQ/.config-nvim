return { {
	"nvim-focus/focus.nvim",
	opts = {
		-- split = { bufnew = false }
	},
	event = 'WinResized'
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
