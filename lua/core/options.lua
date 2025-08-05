local opt = vim.opt

-- Performance optimizations
opt.lazyredraw = true           -- Don't redraw while executing macros
opt.hidden = true               -- Allow switching buffers without saving
opt.updatetime = 300           -- Faster completion (default 4000ms)
opt.timeoutlen = 300           -- Reduce timeout after pressing leader
opt.ttimeoutlen = 10           -- Faster key sequence completion

-- UI improvements
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8              -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8          -- Keep 8 columns left/right of cursor
opt.signcolumn = "yes"         -- Always show sign column
opt.cursorline = true          -- Highlight current line
opt.cursorcolumn = false       -- Don't highlight current column (performance)
opt.wrap = false               -- No line wrapping
opt.linebreak = true           -- Break lines at word boundaries
opt.showbreak = "↪ "          -- Show line break indicator
opt.list = false               -- Don't show whitespace characters by default
opt.listchars = { tab = "→ ", eol = "↲", nbsp = "␣", trail = "•", extends = "⟩", precedes = "⟨" }

-- Search improvements
opt.ignorecase = true          -- Case insensitive search
opt.smartcase = true           -- Case sensitive when uppercase present
opt.incsearch = true           -- Incremental search
opt.hlsearch = true            -- Highlight search results
opt.gdefault = true            -- Global search by default

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

-- File handling
opt.backup = false             -- No backup files
opt.writebackup = false        -- No write backup
opt.swapfile = false           -- No swap files
opt.undofile = true            -- Persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Performance
opt.completeopt = "menu,menuone,noselect,noinsert" -- Better completion
opt.pumheight = 10             -- Limit popup menu height
opt.pumblend = 10              -- Popup menu transparency
opt.winblend = 10              -- Window transparency
opt.mouse = "a"                -- Enable mouse in all modes
opt.clipboard = "unnamedplus"  -- Use system clipboard

-- Folding
opt.foldmethod = "indent"      -- Fold by indent
opt.foldlevelstart = 99        -- Start with all folds open
opt.foldnestmax = 10           -- Maximum fold nesting

-- Terminal
opt.scrollback = 10000         -- Terminal scrollback buffer size
