return {
  "NeogitOrg/neogit",
  dependencies = "nvim-lua/plenary.nvim",
	lazy = true,
  keys = {
    { "<leader>G", "<cmd>Neogit<CR>", desc = "Open neogit" },
  },
  opts = {
    use_magit_keybindings = true,
    auto_refresh = true,
  },
}
