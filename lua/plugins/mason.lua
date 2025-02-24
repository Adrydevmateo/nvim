return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		keys = {
			{ "<leader>m", "<cmd>Mason<cr>", desc = "Mason" },
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				---@type string[]
				ensure_installed = require("utils.servers"),
			})
		end,
	},
} -- finish
