-- lua/keymaps.lua
local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>")

vim.g.mapleader = " " 
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], { noremap = true })

vim.keymap.set('n', '<Leader>wh', '<C-w>h', { desc = '左のウィンドウへ移動' })
vim.keymap.set('n', '<Leader>wj', '<C-w>j', { desc = '下のウィンドウへ移動' })
vim.keymap.set('n', '<Leader>wk', '<C-w>k', { desc = '上のウィンドウへ移動' })
vim.keymap.set('n', '<Leader>wl', '<C-w>l', { desc = '右のウィンドウへ移動' })
vim.keymap.set('n', '<Leader>wv', '<cmd>vsplit<cr>', { desc = '垂直分割' })
vim.keymap.set('n', '<Leader>ww', '<C-w>w', { desc = '次のウィンドウへ移動' })
