return { {
	"nvim-focus/focus.nvim",
	opts = {},
	event = 'VeryLazy'
}, {
	"folke/zen-mode.nvim",
	init = function ()
		vim.keymap.set('n', '<leader><BS>', ':ZenMode<CR>', { noremap = true, silent = true })
	end,
	cmd = "ZenMode"
}, {
	"folke/twilight.nvim",
	cmd = { "Twilight", "TwilightEnable" }
}, {
	"LZDQ/nvim-autocenter",
	dev = false,
	opts = {
		-- when = 'always'
	}
}, {
	"shortcuts/no-neck-pain.nvim",
	enabled = false,
	-- event = 'VeryLazy'
} }
