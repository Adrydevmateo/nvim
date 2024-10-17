return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
			{
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
},
			'saadparwaiz1/cmp_luasnip'
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lsp = require("lspconfig")
			local util = require("lspconfig.util")
			local cmp = require("cmp")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local ls = require("luasnip")

			-- Snippert setup
			require("luasnip.loaders.from_vscode").lazy_load()

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
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end
          })
        end
      end

			-- [ Servers ]
			lsp.ts_ls.setup({
				capabilities = capabilities,
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
				init_options = { hostInfo = "neovim" },
				root_dir = util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
				single_file_support = true,
				on_attach = function (client, bufnr)
					lsp_format_on_save(client, bufnr)
				end,
			})
		end
	}
}
