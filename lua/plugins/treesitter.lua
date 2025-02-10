return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = require("core.languages").parsers,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
