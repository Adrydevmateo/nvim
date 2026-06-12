local opt = vim.opt

opt.number = true		      -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.scrolloff = 10		    -- Keep 8 lines above/below cursor
opt.sidescrolloff = 2		  -- Keep 8 columns left/right of cursor
opt.showbreak = "↪ "		  -- Show break indicator

-- indentation
opt.expandtab = true	  -- Use spaces instead of tabs
opt.shiftwidth = 2	    -- Number of spaces for auto-indent
opt.tabstop = 2		      -- Number of spaces that a tab counts for
opt.softtabstop = 2	    -- Number of spaces for tab in insert mode
opt.autoindent = true	  -- Copy indent from current line
opt.smartindent = true  -- Smart auto-indent

-- search settings
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true  -- Don't ignore case if search contains uppercase

-- file handling
opt.autoread = true -- Auto-reload files changed outside vim

-- ui behavior
opt.cursorline = true     -- Highlight current line
opt.termguicolors = true  -- Enable true color
