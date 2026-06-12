return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Matches your palette colors perfectly
        transparent_background = true, -- Forces transparency to inherit terminal bg
        term_colors = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          telescope = { enabled = true },
        },
      })

      -- Set the colorscheme
      vim.cmd.colorscheme("catppuccin")

      -- Ensure floating windows and borders are also transparent
      local hl_groups = {
        "NormalFloat", "NormalNC", "SignColumn", "FoldColumn",
        "LineNr", "CursorLineNr", "GitSignsAdd", "GitSignsChange", "GitSignsDelete"
      }
      for _, group in ipairs(hl_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
      end
    end,
  }
}
