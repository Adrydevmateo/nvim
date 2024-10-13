function _G.load_mason()
			-- Setup Mason
			require("mason").setup()

			-- Setup Mason LSPConfig
			require("mason-lspconfig").setup({
				ensure_installed = { "biome", "gopls" },
			})
end

-- Function to load LSPConfig
function _G.load_lspconfig()
			-- Setup LSP configurations
			local lspconfig = require("lspconfig")

			-- Function to set up LSP capabilities and on_attach
			local on_attach = function(client, bufnr)
    				-- Key mappings for LSP functions
				local opts = { noremap = true, silent = true }
    				vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    				vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	    			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
    				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
			end

			-- Configure each installed server
			local servers = { "biome", "gopls" } -- Add your desired LSP servers

			lspconfig.biome.setup({
				filetypes = { "javascript", "css", "json" },
				on_attach = on_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			})
end


return {
	{
		'neovim/nvim-lspconfig',
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	}
}
