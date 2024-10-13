return {
	{
	"neovim/nvim-lspconfig",
	config = function()
		local lsp = require("lspconfig")

		lsp.gopls.setup({
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
		})
	end
	}
}
