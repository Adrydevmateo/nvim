-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

--Map leader keys
vim.g.mapleader = " "

-- Better save
keymap("n", "<C-s>", ":w<CR>")

-- Better move around
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "<A-j>", "<cmd>execute 'move .+' .. v:count1<cr>==", opts)
keymap("n", "<A-k>", "<cmd>execute 'move .-' .. (v:count1 + 1)<cr>==", opts)
keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", opts)
keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", opts)
keymap("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" .. v:count1<cr>gv=gv", opts)
keymap("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" .. (v:count1 + 1)<cr>gv=gv", opts)

-- Close all buffers then close neovim
keymap("n", "<leader>q", ":%bdelete | qa<CR>")

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
keymap("v", "p", '"_dP', opts)
keymap("v", "c", '"_c', opts)
keymap("n", "x", '"_x', opts)
keymap("n", "X", '"_X', opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
