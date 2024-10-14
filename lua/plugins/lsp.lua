return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lsp = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lsp.ts_ls.setup({
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
				root_dir = lsp.util.root_pattern("tsconfig.json", "jsconfig.json", ".git"),
			})

			lsp.gopls.setup({
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				capabilities = capabilities,
				root_dir = lsp.util.root_pattern("go.mod", ".git"),
			})
		end,
	},
}
