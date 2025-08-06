-- Performance optimizations for Neovim
-- Disable built-in plugins and optimize settings for speed

local M = {}

-- Disable built-in plugins for better performance
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
  "man",
  "tutor",
  "tohtml",
  "matchparen",
  "shada_plugin",
}

function M.setup()
  -- Disable built-in plugins
  for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
  end

  -- Performance optimizations
  vim.opt.updatetime = 100 -- Faster completion
  vim.opt.timeoutlen = 300 -- Faster key sequence completion
  vim.opt.redrawtime = 1500 -- Allow more time for loading syntax
  vim.opt.synmaxcol = 240 -- Only highlight the first 240 columns
  vim.opt.maxmempattern = 1000 -- Limit the memory used for pattern matching

  -- Additional performance optimizations
  vim.opt.lazyredraw = true -- Don't redraw while executing macros
  vim.opt.ttyfast = true -- Faster terminal connection
  vim.opt.ttimeout = true -- Time out on key codes
  vim.opt.ttimeoutlen = 50 -- Time out on key codes after 50ms
  
  -- Syntax highlighting optimizations
  vim.opt.syntax = "on" -- Enable syntax highlighting
  vim.opt.foldmethod = "indent" -- Use indent folding (faster than syntax)
  vim.opt.foldlevelstart = 99 -- Start with all folds open
  
  -- Search optimizations
  vim.opt.magic = true -- Use magic for patterns
  
  -- File reading optimizations
  vim.opt.modelines = 0 -- Disable modelines for security and performance
  vim.opt.modelineexpr = false -- Disable modeline expressions
  
  -- UI performance
  vim.opt.cursorline = false -- Disable cursor line highlighting (can be slow)
  vim.opt.cursorcolumn = false -- Disable cursor column highlighting (can be slow)
  
  -- Completion optimizations
  vim.opt.completeopt = "menuone,noselect,noinsert" -- Better completion
  vim.opt.pumheight = 10 -- Maximum number of items in completion menu
  vim.opt.pumwidth = 0 -- Let the completion menu size itself
  
  -- Buffer optimizations
  vim.opt.bufhidden = "hide" -- Hide buffers instead of unloading them
  vim.opt.buflisted = true -- List buffers in buffer list
  
  -- Window optimizations
  vim.opt.winminwidth = 0 -- Allow windows to be very narrow
  vim.opt.winminheight = 0 -- Allow windows to be very short
  
  -- Terminal optimizations
  vim.opt.scrollback = 1000 -- Limit scrollback in terminal
  
  -- Disable some features that can slow down editing
  vim.opt.spell = false -- Disable spell checking by default
  vim.opt.spelllang = "en" -- Set spell language when enabled
  
  -- Disable some expensive features by default
  vim.opt.conceallevel = 0 -- Disable conceal by default
  vim.opt.concealcursor = "" -- Disable conceal cursor
  
  -- Optimize for startup speed
  vim.opt.loadplugins = true -- Load plugins on startup
  vim.opt.exrc = false -- Don't load .nvimrc files in current directory
  
  -- Disable some built-in features that can be slow
  vim.opt.showmatch = false -- Don't show matching brackets (can be slow)
  vim.opt.matchtime = 2 -- Show matching brackets for 2 seconds when enabled
  
  -- Optimize for terminal performance
  vim.opt.termguicolors = true -- Use true colors (can be faster than 256 colors)
  vim.opt.guicursor = "" -- Use terminal cursor (faster than GUI cursor)
  
  -- Disable some features that can cause lag
  vim.opt.autochdir = false -- Don't auto-change directory
  vim.opt.autowrite = false -- Don't auto-write files
  vim.opt.autowriteall = false -- Don't auto-write all files
  
  -- Optimize for search performance
  vim.opt.gdefault = true -- Always use global flag for search/replace
  vim.opt.incsearch = true -- Show search matches as you type
  vim.opt.hlsearch = true -- Highlight search matches
  
  -- Disable some expensive features
  vim.opt.ruler = false -- Don't show ruler (can be slow in some terminals)
  vim.opt.showcmd = false -- Don't show partial commands (can be slow)
  
  -- Optimize for file operations
  vim.opt.backup = false -- No backup files
  vim.opt.writebackup = false -- No backup files during write
  vim.opt.swapfile = false -- No swap files
  vim.opt.undofile = true -- Persistent undo (can be slow for large files)
  
  -- Set undo directory
  local undo_dir = vim.fn.stdpath("data") .. "/undo"
  if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(undo_dir, "p")
  end
  vim.opt.undodir = undo_dir
end

return M
