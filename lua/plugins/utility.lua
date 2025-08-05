return {
    {
      "supermaven-inc/supermaven-nvim",
      lazy = false,
      config = function()
        require("supermaven-nvim").setup({})
      end,
    },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<C-n>", function() require("nvim-tree.api").tree.toggle() end, desc = "Toggle NvimTree" },

    },
    config = function()
      require("nvim-tree").setup {
        sort = { sorter = "case_sensitive" },
        filters = {
          dotfiles = true,

        }
      }
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
      { "<C-\\>", mode = "n", desc = "Toggle terminal" },
    },
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
      })
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<space>ff", mode = "n", desc = "Telescope find files" },
      { "<space>fg", mode = "n", desc = "Telescope live grep" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      local builtin = require("telescope.builtin")
      local km = vim.keymap.set

      km("n", "<space>ff", builtin.find_files, { desc = "Telescope find files" })
      km("n", "<space>fg", builtin.live_grep, { desc = "Telescope live grep" })
    end,
  },
}
