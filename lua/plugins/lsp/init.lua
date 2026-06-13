local servers = require("plugins.lsp.servers")

return {
	{
		"williamboman/mason.nvim",
		config = true, -- Runs require("mason").setup()
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			-- Put the servers you want automatically installed here
			ensure_installed = servers,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			-- Listen for LSP connections and apply keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufmap = function(mode, lhs, rhs)
						vim.keymap.set(mode, lhs, rhs, { buffer = args.buf })
					end

					bufmap("n", "gd", vim.lsp.buf.definition)
					bufmap("n", "gr", vim.lsp.buf.references)
					bufmap("n", "gy", vim.lsp.buf.type_definition)
					bufmap("n", "K", vim.lsp.buf.hover)
					bufmap("n", "<leader>ca", vim.lsp.buf.code_action)
				end,
			})

			-- Automatically set up every server installed via mason
			mason_lspconfig.setup({
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({})
					end,
				},
			})
		end,
	},
}
