return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
		{ "nvim-telescope/telescope-file-browser.nvim", lazy = true },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    { "nvim-lua/plenary.nvim" },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>ft", "<cmd>Telescope live_grep<CR>", desc = "Find a string" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Find keymaps" },
    { "<leader>fgb", "<cmd>Telescope git_branches<CR>", desc = "Checkout branch" },
		{ "<leader>fb", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "File browser" },
  },
  config = function()
    local telescope = require "telescope"
    telescope.setup {
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
          hidden = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
				file_browser = {
					theme = "dropdown", -- or "ivy"
					hidden = true, -- or "hide"
				},
      },
      defaults = {
        file_ignore_patterns = { "node_modules/", ".yarn/", ".git/", ".idea/" },
      },
    }
		telescope.load_extension "file_browser"
  end,
}
