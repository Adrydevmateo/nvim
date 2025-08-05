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

require("lazy").setup({
	spec = {
		{import = "plugins"}
	},
	defaults = {
		lazy = true,
		version = false, -- Always use the latest git commit
	},
  checker = {
    enabled = false, -- Disable plugin update checker for performance
    notify = false,
  },
  change_detection = {
    notify = false, -- Disable change detection notifications
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "netrwPlugin",
        "matchparen",
        "matchit",
        "logiPat",
        "rplugin",
        "spellfile",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "logipat",
        "rrhelper",
        "getscript",
        "getscriptPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
    icons = {
      loaded = "●",
      not_loaded = "○",
    },
  },
  install = {
    colorscheme = { "kanagawa" },
  },
})
