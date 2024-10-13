return {
	{ 
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = true,
		config = function ()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "c", "lua", "javascript", "html", "css" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
			})
		end
	}
}
