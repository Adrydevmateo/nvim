-- Lazy.nvim plugin manager configuration
-- Sets up Lazy.nvim for future plugin management

local M = {}

function M.setup()
  -- Bootstrap Lazy.nvim
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  -- Load plugin specifications
  local plugins = require("plugins")
  
  -- Configure Lazy.nvim
  require("lazy").setup(plugins.plugins, {
    -- Performance optimizations
    concurrency = 10, -- Number of concurrent git processes
    git = {
      timeout = 120, -- Git operations timeout
    },
    install = {
      colorscheme = { "default" }, -- Don't install colorscheme plugins
    },
    ui = {
      border = "rounded", -- Border style for Lazy UI
      icons = {
        cmd = "⌘",
        config = "🛠",
        event = "📅",
        ft = "📂",
        init = "⚙",
        keys = "🗝",
        plugin = "🔌",
        runtime = "💻",
        require = "🌙",
        source = "📄",
        start = "🚀",
        task = "📋",
        lazy = "💤 ",
      },
    },
    checker = {
      enabled = false, -- Disable plugin version checker for performance
    },
    change_detection = {
      enabled = false, -- Disable change detection for performance
    },
    performance = {
      rtp = {
        reset = false, -- Don't reset runtime path
        paths = {}, -- Additional paths
        disabled_plugins = {
          -- Disable plugins that might conflict with our setup
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
        },
      },
    },
  })
end

return M
