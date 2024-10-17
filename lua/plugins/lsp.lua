return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			{
				'L3MON4D3/LuaSnip',
				dependencies = { 'rafamadriz/friendly-snippets' },
			},
			'saadparwaiz1/cmp_luasnip'
		},
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			local lsp = require('lspconfig')
			local util = require('lspconfig.util')
			local cmp = require('cmp')
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			-- Snippert setup
			require('luasnip.loaders.from_vscode').lazy_load()

			-- Completion setup
			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept the selected item.
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' }, -- Uncomment for LuaSnip users.
				}, {
					{ name = 'buffer' },
				})
			})

			-- Cmdline configuration
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				}),
			})

			-- Function to format on save
			local function lsp_format_on_save(client, bufnr)
				if client.supports_method('textDocument/formatting') then
					vim.api.nvim_create_autocmd('BufWritePre', {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end
					})
				end
			end

			-- [ Servers ]
			-- TS Server
			lsp.ts_ls.setup({
				capabilities = capabilities,
				cmd = { 'typescript-language-server', '--stdio' },
				filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
				init_options = { hostInfo = 'neovim' },
				root_dir = util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git'),
				single_file_support = true,
				on_attach = function(client, bufnr)
					lsp_format_on_save(client, bufnr)
				end,
			})

			-- HTML Server
			lsp.html.setup({
				cmd = { "vscode-html-language-server", "--stdio" },
				filetypes = { "html", "templ" },
				init_options = {
					configurationSection = { "html", "css", "javascript" },
					embeddedLanguages = {
						css = true,
						javascript = true
					},
					provideFormatter = true
				},
				settings = {},
				single_file_support = true,
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					lsp_format_on_save(client, bufnr)
				end,
			})

			-- CSS Server
			lsp.cssls.setup({
				cmd = { "vscode-css-language-server", "--stdio" },
				filetypes = { "css", "scss", "less" },
				init_options = { provideFormatter = true },
				root_dir = util.root_pattern("package.json", ".git") or bufdir,
				settings = {
					css = {
						validate = true
					},
					less = {
						validate = true
					},
					scss = {
						validate = true
					}
				},
				single_file_support = true,
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					lsp_format_on_save(client, bufnr)
				end,
			})


			-- Lua | Server
			lsp.lua_ls.setup({
				cmd = { 'lua-language-server' },
				filetypes = { 'lua' },
				log_level = 2,
				single_file_support = true,
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					lsp_format_on_save(client, bufnr)
				end,
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend('force',
						client.config.settings.Lua, {
							runtime = {
								-- Tell the language server which version of Lua you're using
								-- (most likely LuaJIT in the case of Neovim)
								version = 'LuaJIT'
							},
							-- Make the server aware of Neovim runtime files
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME
									-- Depending on the usage, you might want to add additional paths here.
									-- '${3rd}/luv/library'
									-- '${3rd}/busted/library',
								}
								-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
								-- library = vim.api.nvim_get_runtime_file('', true)
							}
						})
				end,
				settings = {
					Lua = {}
				}
			})
		end
	}
}
