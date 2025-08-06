-- Key mappings for efficiency
-- All custom key bindings for navigation, editing, and file operations

local M = {}

function M.setup()
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- Set leader key
  vim.g.mapleader = " "

  -- Quick navigation
  map("n", "<C-h>", "<C-w>h", opts)
  map("n", "<C-j>", "<C-w>j", opts)
  map("n", "<C-k>", "<C-w>k", opts)
  map("n", "<C-l>", "<C-w>l", opts)

  -- Buffer navigation
  map("n", "<S-l>", ":bnext<CR>", opts)
  map("n", "<S-h>", ":bprevious<CR>", opts)

  -- Quick save and quit
  map("n", "<leader>w", ":w<CR>", opts)
  map("n", "<leader>q", ":q<CR>", opts)
  map("n", "<leader>Q", ":q!<CR>", opts)

  -- Search improvements
  map("n", "n", "nzzzv", opts)
  map("n", "N", "Nzzzv", opts)
  map("n", "*", "*zzzv", opts)
  map("n", "#", "#zzzv", opts)

  -- Quick escape from insert mode
  map("i", "jj", "<Esc>", opts)
  map("i", "jk", "<Esc>", opts)

  -- Move lines up and down
  map("n", "<A-j>", ":m .+1<CR>==", opts)
  map("n", "<A-k>", ":m .-2<CR>==", opts)
  map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
  map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
  map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
  map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

  -- Quick select all
  map("n", "<leader>a", "ggVG", opts)

  -- Toggle search highlighting
  map("n", "<leader>h", ":set hlsearch!<CR>", opts)

  -- Quick find and replace
  map("n", "<leader>r", ":%s/", opts)

  -- Yank to system clipboard
  map("n", "<leader>y", '"+y', opts)
  map("v", "<leader>y", '"+y', opts)
  map("n", "<leader>Y", '"+yg_', opts)

  -- Paste from system clipboard
  map("n", "<leader>p", '"+p', opts)
  map("v", "<leader>p", '"+p', opts)
  map("n", "<leader>P", '"+P', opts)
  map("v", "<leader>P", '"+P', opts)

  -- Terminal keymaps
  map("n", "<leader>tt", ":ToggleTerm<CR>", opts) -- Toggle terminal
  map("n", "<leader>tf", ":ToggleTerm direction=float<CR>", opts) -- Toggle float terminal
  map("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", opts) -- Toggle horizontal terminal
  map("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", opts) -- Toggle vertical terminal
  
  -- Terminal mode keymaps (when in terminal)
  map("t", "<Esc>", "<C-\\><C-n>", opts) -- Exit terminal mode with Esc
  map("t", "jj", "<C-\\><C-n>", opts) -- Exit terminal mode with jj
  map("t", "jk", "<C-\\><C-n>", opts) -- Exit terminal mode with jk
end

return M
