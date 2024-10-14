return {
	{
	"neovim/nvim-lspconfig",
	config = function()
		local lsp = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		lsp.gopls.setup({
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			capabilities = capabilities
		})
	end
	}
}
