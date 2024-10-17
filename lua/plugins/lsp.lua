return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lsp = require("lspconfig")
			local util = require("lspconfig.util")

			lsp.ts_ls.setup({
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
				init_options = { hostInfo = "neovim" },
				root_dir = util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
				single_file_support = true
			})
		end
	}
}
