-- Initialize Neovim configuration with error handling
local startup = require("core.startup")

-- Initialize core modules
startup.init()

-- Run health check after initialization
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    startup.check_health()
  end,
  once = true,
})

