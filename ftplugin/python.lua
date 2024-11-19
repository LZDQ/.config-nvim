vim.g.is_pythonsense_suppress_keymaps = 1

-- map <buffer> ad <Plug>(PythonsenseOuterDocStringTextObject)
vim.keymap.set({"v", "o"}, 'ad', '<Plug>(PythonsenseOuterDocStringTextObject)', { noremap = true, buffer = 0 })
vim.keymap.set({"v", "o"}, 'id', '<Plug>(PythonsenseInnerDocStringTextObject)', { noremap = true, buffer = 0 })
