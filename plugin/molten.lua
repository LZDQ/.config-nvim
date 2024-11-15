-- Interactive python
vim.keymap.set("n", "mi", ":MoltenInit<CR>",
{ silent = true, desc = "Initialize the plugin" })
vim.keymap.set("n", "me", ":MoltenEvaluateOperator<CR>",
{ silent = true, desc = "run operator selection" })
vim.keymap.set("n", "ml", ":MoltenEvaluateLine<CR>",
{ silent = true, desc = "evaluate line" })
vim.keymap.set("n", "mr", ":MoltenReevaluateCell<CR>",
{ silent = true, desc = "re-evaluate cell" })
vim.keymap.set("v", "m", ":<C-u>MoltenEvaluateVisual<CR>",
{ silent = true, desc = "evaluate visual selection" })
vim.keymap.set("n", "md", ":MoltenDelete<CR>",
{ silent = true, desc = "delete current cell" })
vim.keymap.set("n", "mh", ":MoltenHideOutput<CR>",
{ silent = true, desc = "hide output of current cell" })
