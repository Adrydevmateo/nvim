local g = vim.g
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

g.mapleader = " "

-- system clipboard yank
map({ "n", "v" }, "<leader>y", '"+y', opts)

-- window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
