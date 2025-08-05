local km = vim.keymap.set
local opt = { silent = true, noremap = true }

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Window navigation
km("n", "<C-h>", "<C-w>h", opt)
km("n", "<C-j>", "<C-w>j", opt)
km("n", "<C-k>", "<C-w>k", opt)
km("n", "<C-l>", "<C-w>l", opt)

-- Window management
km("n", "<leader>wv", "<C-w>v", opt) -- Split vertically
km("n", "<leader>ws", "<C-w>s", opt) -- Split horizontally
km("n", "<leader>wc", "<C-w>c", opt) -- Close window
km("n", "<leader>wo", "<C-w>o", opt) -- Close other windows

-- Buffer navigation
km("n", "<leader>bn", ":bnext<CR>", opt)
km("n", "<leader>bp", ":bprevious<CR>", opt)
km("n", "<leader>bd", ":bdelete<CR>", opt)
km("n", "<leader>ba", ":bufdo bdelete<CR>", opt)

-- Tab navigation
km("n", "<leader>tn", ":tabnew<CR>", opt)
km("n", "<leader>tc", ":tabclose<CR>", opt)
km("n", "<leader>to", ":tabonly<CR>", opt)
km("n", "<leader>th", ":tabprevious<CR>", opt)
km("n", "<leader>tl", ":tabnext<CR>", opt)

-- Quick save and quit
km("n", "<leader>w", ":w<CR>", opt)
km("n", "<leader>q", ":q<CR>", opt)
km("n", "<leader>Q", ":qa!<CR>", opt)

-- Search improvements
km("n", "n", "nzzzv", opt) -- Keep search results centered
km("n", "N", "Nzzzv", opt)
km("n", "*", "*zzzv", opt)
km("n", "#", "#zzzv", opt)
km("n", "g*", "g*zzzv", opt)
km("n", "g#", "g#zzzv", opt)

-- Clear search highlights
km("n", "<leader><CR>", ":nohlsearch<CR>", opt)

-- Better indentation
km("v", "<", "<gv", opt)
km("v", ">", ">gv", opt)

-- Move lines up and down
km("n", "<A-j>", ":m .+1<CR>==", opt)
km("n", "<A-k>", ":m .-2<CR>==", opt)
km("v", "<A-j>", ":m '>+1<CR>gv=gv", opt)
km("v", "<A-k>", ":m '<-2<CR>gv=gv", opt)

-- Center cursor after jumps
km("n", "G", "Gzz", opt)
km("n", "gg", "ggzz", opt)
km("n", "<C-o>", "<C-o>zz", opt)
km("n", "<C-i>", "<C-i>zz", opt)

-- Quick escape from terminal
km("t", "<Esc>", "<C-\\><C-n>", opt)

-- Reselect visual selection after indenting
km("v", "<", "<gv", opt)
km("v", ">", ">gv", opt)

-- Keep cursor in place when joining lines
km("n", "J", "mzJ`z", opt)

-- Quick edit config files
km("n", "<leader>ev", ":e $MYVIMRC<CR>", opt)
km("n", "<leader>sv", ":source $MYVIMRC<CR>", opt)

-- Toggle options
km("n", "<leader>tw", ":set wrap!<CR>", opt)
km("n", "<leader>tN", ":set number!<CR>", opt)
km("n", "<leader>tr", ":set relativenumber!<CR>", opt)
km("n", "<leader>tL", ":set list!<CR>", opt)

-- Quick file operations
km("n", "<leader>cd", ":cd %:p:h<CR>", opt) -- Change to current file directory
km("n", "<leader>pwd", ":pwd<CR>", opt) -- Show current directory

-- Yank to system clipboard
km("n", "<leader>y", '"+y', opt)
km("v", "<leader>y", '"+y', opt)
km("n", "<leader>Y", '"+yg_', opt)

-- Paste from system clipboard
km("n", "<leader>p", '"+p', opt)
km("v", "<leader>p", '"+p', opt)
km("n", "<leader>P", '"+P', opt)
km("v", "<leader>P", '"+P', opt)

-- Delete without yanking
km("n", "<leader>d", '"_d', opt)
km("v", "<leader>d", '"_d', opt)

-- Change without yanking
km("n", "<leader>c", '"_c', opt)
km("v", "<leader>c", '"_c', opt)

-- Quick macro execution
km("n", "Q", "@q", opt)

-- Disable arrow keys in normal mode (encourage hjkl usage)
km("n", "<Up>", "<Nop>", opt)
km("n", "<Down>", "<Nop>", opt)
km("n", "<Left>", "<Nop>", opt)
km("n", "<Right>", "<Nop>", opt)

-- Quick access to common commands
km("n", "<leader>h", ":help ", opt)
km("n", "<leader>H", ":help", opt)
