return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		automatic_setup = true,
		ensure_installed = require("utils.formatters_linters"),
		automatic_installation = true,
	},
	dependencies = {
		{
			"nvimtools/none-ls.nvim",
			dependencies = "nvim-lua/plenary.nvim",
			keys = {
				{
					"<leader>lf",
					"<cmd>lua vim.lsp.buf.format{ async = true }<cr>",
					desc = "Format",
				},
			},
			config = function()
				local null_ls = require("null-ls")
				local formatting = null_ls.builtins.formatting

				null_ls.setup({
					debug = false,
					sources = {
						formatting.prettier,
						formatting.stylua,
						formatting.black,
					},
				})
			end,
		},
	},
}
