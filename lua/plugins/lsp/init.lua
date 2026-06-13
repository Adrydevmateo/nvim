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
			-- mason_lspconfig.setup({
			-- 	handlers = {
			-- 		function(server_name)
			-- 			lspconfig[server_name].setup({})
			-- 		end,
			-- 	},
			-- })
			mason_lspconfig.setup({
				handlers = {
					-- The default handler for all servers
					function(server_name)
						lspconfig[server_name].setup({})
					end,

					-- Specific handler for ts_ls (Disable standard JS/TS files, keep Vue)
					["ts_ls"] = function()
						lspconfig.ts_ls.setup({
							filetypes = { "vue" }, -- Strips away js, ts, jsx, tsx
							init_options = {
								plugins = {
									{
										name = "@vue/typescript-plugin",
										location = require("mason-registry")
											.get_package("vue-language-server")
											:get_install_path() .. "/libexec/@vue/language-server",
										languages = { "vue" },
									},
								},
							},
						})
					end,

					-- Specific handler for Biome (Targets pure web languages)
					["biome"] = function()
						lspconfig.biome.setup({
							filetypes = {
								"javascript",
								"javascriptreact",
								"typescript",
								"typescriptreact",
								"json",
								"jsonc",
							},
						})
					end,
				},
			})
		end,
	},
}
