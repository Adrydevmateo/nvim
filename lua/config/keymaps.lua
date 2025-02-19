-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

--Map leader keys
vim.g.mapleader = " "

------------- Normal Mode -------------
-- Better move around
keymap("n", "<C-s>", ":w<CR>")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Close all buffers then close neovim
keymap("n", "<leader>q", ":%bdelete | qa<CR>")


-- Better Window Navigation
-- Window Keymap
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- Buffer keymap
keymap("n", "<C-H>", "<C-W><C-H>", opts)
keymap("n", "<C-J>", "<C-W><C-J>", opts)
keymap("n", "<C-K>", "<C-W><C-K>", opts)
keymap("n", "<C-L>", "<C-W><C-L>", opts)

-- Better paste
-- keymap("v", "p", '"_dP', opts)
-- keymap("n", "x", '"_x', opts)
-- keymap("n", "X", '"_X', opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Netrw
vim.keymap.set("n", "<leader>.", vim.cmd.Ex, { silent = true, noremap = true })
