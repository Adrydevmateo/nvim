-- TODO
local options = require("plugins.snacks.options")
local keymaps = require("plugins.snacks.keymaps")

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = options,
    keys = keymaps,
  }
}
