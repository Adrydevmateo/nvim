-- Set editor options (tab size, line numbers, etc.).

-- [ color ]
vim.cmd('colorscheme kanagawa')

-- [ Numbers ]
-- vim.cmd('set relativenumber')
-- vim.cmd('set numberwidth=3')

-- [ Indentation ]
vim.cmd('set tabstop=4')    -- Number of spaces a <Tab> counts for
vim.cmd('set shiftwidth=4') -- Number of spaces to use for autoindent
vim.cmd('set expandtab')    -- Convert tabs to spaces
vim.cmd('set autoindent')   -- Copy indent from current line when starting a new line
vim.cmd('set smartindent')  -- Makes indenting smart (for languages like C)

-- Responsiveness
vim.cmd('set timeoutlen=300')
