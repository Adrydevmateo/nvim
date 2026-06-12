return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      dashboard = { enabled = true, example = "github" },
      picker = { enabled = true },
      explorer = { enabled = true },
    },
    keys = {
      -- Pickers
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      -- Explorer
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    },
  }
}
