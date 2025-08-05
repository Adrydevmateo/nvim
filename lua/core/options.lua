local opt = vim.opt
local g = vim.g

-- General
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.completeopt = "menuone,noselect"

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Indent
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Performance
opt.hidden = true
opt.history = 100
opt.lazyredraw = true
opt.synmaxcol = 240
opt.updatetime = 250

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.showmode = false
opt.laststatus = 3
opt.winbar = "%=%m %f"

-- Split
opt.splitbelow = true
opt.splitright = true

-- Backup
opt.backup = false
opt.writebackup = false

-- Global options
g.mapleader = " "
g.maplocalleader = " " 