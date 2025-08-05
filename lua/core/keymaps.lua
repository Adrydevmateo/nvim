local km = vim.keymap.set
local opt = { silent = true, noremap = true }

km("n", "<C-h>", "<C-w>h", opt)
km("n", "<C-j>", "<C-w>j", opt)
km("n", "<C-k>", "<C-w>k", opt)
km("n", "<C-l>", "<C-w>l", opt)
