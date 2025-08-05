local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General
map("n", "<leader>w", "<cmd>w<cr>", opts)
map("n", "<leader>q", "<cmd>q<cr>", opts)
map("n", "<leader>Q", "<cmd>qa!<cr>", opts)
map("n", "<leader>h", "<cmd>nohlsearch<cr>", opts)

-- Window management
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<leader>sv", "<cmd>vsplit<cr>", opts)
map("n", "<leader>sh", "<cmd>split<cr>", opts)

-- Buffer management
map("n", "<leader>bn", "<cmd>bnext<cr>", opts)
map("n", "<leader>bp", "<cmd>bprevious<cr>", opts)
map("n", "<leader>bd", "<cmd>bdelete<cr>", opts)

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", opts)
map("n", "<A-k>", "<cmd>m .-2<cr>==", opts)
map("v", "<A-j>", ":m '>+1<cr>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<cr>gv=gv", opts)

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

-- LSP
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)

-- Toggleterm
map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", opts)
map("t", "<Esc>", "<C-\\><C-n>", opts)

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts)
map("n", "<leader>o", "<cmd>NvimTreeFocus<cr>", opts) 