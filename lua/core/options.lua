-- Core editor options and settings
-- Handles basic editor behavior, indentation, search, and file handling

local M = {}

function M.setup()
  -- Core editor settings
  vim.opt.number = true -- Show line numbers
  vim.opt.relativenumber = false -- Show relative line numbers
  vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor
  vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
  vim.opt.wrap = false -- No line wrapping
  vim.opt.linebreak = true -- Break lines at word boundaries when wrapping
  vim.opt.showbreak = "↪ " -- Show break indicator
  vim.opt.list = true -- Show invisible characters
  vim.opt.listchars = { tab = "▸ ", trail = "·", extends = "❯", precedes = "❮" }

  -- Indentation
  vim.opt.expandtab = true -- Use spaces instead of tabs
  vim.opt.shiftwidth = 2 -- Number of spaces for auto-indent
  vim.opt.tabstop = 2 -- Number of spaces that a tab counts for
  vim.opt.softtabstop = 2 -- Number of spaces for tab in insert mode
  vim.opt.autoindent = true -- Copy indent from current line
  vim.opt.smartindent = true -- Smart auto-indent

  -- Search settings
  vim.opt.ignorecase = true -- Ignore case in search
  vim.opt.smartcase = true -- Don't ignore case if search contains uppercase

  -- File handling
  vim.opt.hidden = true -- Allow switching buffers without saving
  vim.opt.autoread = true -- Auto-reload files changed outside vim

  -- UI improvements
  vim.opt.wildmenu = true -- Command-line completion menu
  vim.opt.wildmode = "list:longest" -- Complete longest common string, then list
  vim.opt.laststatus = 2 -- Always show status line
  vim.opt.signcolumn = "yes" -- Always show sign column
  vim.opt.background = "dark" -- Dark background
end

return M
