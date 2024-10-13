local function map(mode, lhs, rhs, opts)
	opts = opts or { noremap = true, silent = true }
	vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- Set leader key to space
vim.g.mapleader = " "

-- Maps Ctrl + s to save the current file
map('n', '<C-s>', ':w<CR>')

-- Map <C-p> to toggle neotree
map('n', '<C-p>', ':Neotree toggle<CR>')

-- Splits the window verticaly 
map("n", "<Leader>o", ":vsplit<CR>")

-- Splits the window horizontaly
map("n", "<Leader>h", ":split<CR>")

-- Window Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")



-- [[ Autocommands Related ]]
--
-- [ Map <Leader>ts to execute the Treesitter setup command | TreesitterSetup ]
vim.api.nvim_set_keymap('n', '<Leader>ts', ':TreesitterSetup<CR>', { noremap = true, silent = true })

-- [ Map <Leader>q to execute the QuiAll command ]
vim.api.nvim_set_keymap('n', '<Leader>q', ':QuitAll<CR>', { noremap = true, silent = true })
