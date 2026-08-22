local opt = vim.opt

opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.scrolloff = 2 -- Keep 8 lines above/below cursor
opt.sidescrolloff = 2 -- Keep 8 columns left/right of cursor
opt.showbreak = "↪ " -- Show break indicator
opt.spell = true -- Enable spell checking
opt.spelllang = { "en_us" } -- Set spell checker language

-- indentation
opt.expandtab = false -- Insert real tabs instead of spaces
opt.shiftwidth = 4 -- Size of an indent step
opt.tabstop = 4 -- Number of spaces that a tab counts for
opt.softtabstop = 4 -- Number of spaces that a tab counts for in insert mode
opt.autoindent = true -- Copy indent from current line
opt.smartindent = true -- Smart auto-indent

-- search settings
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true -- Don't ignore case if search contains uppercase

-- file handling
opt.autoread = true -- Auto-reload files changed outside vim

-- ui behavior
opt.cursorline = true -- Highlight current line
opt.termguicolors = true -- Enable true color
