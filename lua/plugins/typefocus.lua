return { {
	"nvim-focus/focus.nvim",
	opts = {
		-- split = { bufnew = false }
	},
	init = function ()
		vim.api.nvim_create_autocmd('WinEnter', {
			callback = function(_)
				local ignore_buftypes = {
					"nofile",
					"nowrite",
				}
				if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
					vim.w.focus_disable = true
				else
					vim.w.focus_disable = false
				end
			end,
			desc = 'Disable focus autoresize for special buftypes',
		})
	end
}, {
	"folke/zen-mode.nvim",
	init = function()
		vim.keymap.set('n', '<leader><BS>', '<CMD>ZenMode<CR>')
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
} }
