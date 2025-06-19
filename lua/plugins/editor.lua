local utils = require("core.utils")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({

        ensure_installed = utils.treesitter_languages,
      })
    end,

  },
}
