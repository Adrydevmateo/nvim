return {
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   lazy = false,    -- This makes it load immediately
  --   priority = 1000, -- Ensures it loads before other plugins (optional but recommended for colorschemes)
  --   opts = {
  --     -- Your Catppuccin configuration options here
  --     flavour = "mocha", -- "mocha",  "latte", "frappe", "macchiato"
  --     -- ... other opts
  --   },
  --   config = function(_, opts)
  --     require("catppuccin").setup(opts)
  --     vim.cmd.colorscheme("catppuccin") -- Apply the colorscheme
  --   end,
  -- },

  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = false,    -- This makes it load immediately
    priority = 1000, -- Ensures it loads before other plugins (optional but recommended for colorschemes)
    config = function()
      require("kanagawa").setup()
      vim.cmd.colorscheme("kanagawa-dragon") -- Apply the colorscheme
    end,
  }
}
