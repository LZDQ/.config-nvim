-- fzf, telescope, leap, harpoon
-- Most file and buffer jumps starts with ';'

-- require('leap').create_default_mappings()
local leap = require('leap')
vim.keymap.set('n', 'S', '<Plug>(leap)')
vim.keymap.set('n', '<leader>S', '<Plug>(leap-from-window)')
leap.opts.safe_labels = 'fnugzmwebt/FHLUNSBWETQ?'
-- leap.opts.labels = 'fnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?'
leap.opts.labels = ''

require('telescope').setup {
	defaults = {
		mappings = {
			n = {
				["q"] = require('telescope.actions').close,
			},
			i = {
				["<esc>"] = require('telescope.actions').close,
				["<C-J>"] = require('telescope.actions').move_selection_next,
				["<C-K>"] = require('telescope.actions').move_selection_previous,
				["<C-F>"] = require('telescope.actions').preview_scrolling_down,
				["<C-B>"] = require('telescope.actions').preview_scrolling_up,
			}
		}
	},
	pickers = {
		colorscheme = {
			enable_preview = true
		}
	}
}
vim.keymap.set('n', ';f', ":Files<CR>", { silent = true, noremap = true})
vim.keymap.set('n', ';F', require('telescope.builtin').find_files, {})
vim.keymap.set('n', ';g', require('telescope.builtin').live_grep, {})
vim.keymap.set('n', ';G', function() vim.cmd("Rg") end, {})
vim.keymap.set('n', ';b', function() vim.cmd("Buffers") end, {})
vim.keymap.set('n', ';B', require('telescope.builtin').buffers, {})
vim.keymap.set('n', ';l', function() vim.cmd("Lines") end, {})
vim.keymap.set('n', ';t', require('telescope.builtin').builtin, {})
vim.keymap.set('n', ';k', require('telescope.builtin').keymaps, {})

-- " fzf in CURRENT buffer
-- nnoremap <silent>;l :Lines<CR>
-- " fzf in files in this folder (use ctrlp instead)
-- nnoremap <silent>;f :Files<CR>
-- " fzf open buffer
-- nnoremap <silent>;b :Buffers<CR>
-- " fzf open ripgrep finder
-- nnoremap <silent>;g :Rg<CR>

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers").new({
		-- Defaults to normal mode
		initial_mode = 'normal',
	}, {
		prompt_title = "Harpoon",
		finder = require("telescope.finders").new_table({
			results = file_paths,
		}),
		previewer = conf.file_previewer({}),
		sorter = conf.generic_sorter({}),
	}):find()
end

vim.keymap.set("n", ";a", function() harpoon:list():add() end)
vim.keymap.set("n", ";h", function()
	-- toggle_telescope(harpoon:list())
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open harpoon window" }
)
-- Switch to harpoon buffer
vim.keymap.set("n", ";1", function() harpoon:list():select(1) end)
vim.keymap.set("n", ";2", function() harpoon:list():select(2) end)
vim.keymap.set("n", ";3", function() harpoon:list():select(3) end)
vim.keymap.set("n", ";4", function() harpoon:list():select(4) end)
-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", ";p", function() harpoon:list():prev() end)
vim.keymap.set("n", ";n", function() harpoon:list():next() end)
