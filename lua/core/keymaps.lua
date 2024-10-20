local function set(mode, lhs, rhs, opts)
    opts = opts or { noremap = true, silent = true }
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Set leader key to space
vim.g.mapleader = ' '

-- Key mappings using set
set('n', '<C-s>', ':w<CR>')              -- Save file
set('i', '<C-s>', ':<Esc>:w<CR>i')       -- Save file
set('n', '<C-p>', ':Neotree toggle<CR>') -- Toggle NeoTree
set('n', '<Leader>o', ':vsplit<CR>')     -- Vertical split
set('n', '<Leader>h', ':split<CR>')      -- Horizontal split

-- Window navigation
set('n', '<C-h>', '<C-w>h')
set('n', '<C-l>', '<C-w>l')
set('n', '<C-k>', '<C-w>k')
set('n', '<C-j>', '<C-w>j')

-- LSP-related mappings
set('n', 'gd', vim.lsp.buf.definition)          -- Go to definition
set('n', 'K', vim.lsp.buf.hover)                -- Show hover
set('n', '<Leader>ca', vim.lsp.buf.code_action) -- Code action
set('n', '<Leader>rn', vim.lsp.buf.rename)      -- Rename symbol
set('n', '[d', vim.diagnostic.goto_prev)        -- Go to previous diagnostic
set('n', ']d', vim.diagnostic.goto_next)        -- Go to next diagnostic

-- Map <Leader>q to execute the QuitAll command
set('n', '<Leader>q', ':QuitAll<CR>')
