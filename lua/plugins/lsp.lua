return {
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	config = function()
	-- 		local lsp = require("lspconfig")
	-- 		local capabilities = require("cmp_nvim_lsp").default_capabilities()
	--
	-- 		lsp.ts_ls.setup({
	-- 			cmd = { "typescript-language-server", "--stdio" },
	-- 			filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	-- 			root_dir = lsp.util.root_pattern("tsconfig.json", "jsconfig.json", ".git"),
	-- 		})
	--
	-- 		lsp.gopls.setup({
	-- 			cmd = { "gopls" },
	-- 			filetypes = { "go", "gomod", "gowork", "gotmpl" },
	-- 			capabilities = capabilities,
	-- 			root_dir = lsp.util.root_pattern("go.mod", ".git"),
	-- 		})
	-- 	end,
	-- },
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
			})
			require("mason-lspconfig").setup_handlers({
				function(server_name) --default handler
					require("lspconfig")[server_name].setup({})
				end,
				-- [ Dedicated Handlers ]
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
							},
						},
					})
				end,
			})
		end,
	},
}
