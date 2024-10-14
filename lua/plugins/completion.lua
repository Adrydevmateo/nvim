return {
	{
  		"hrsh7th/nvim-cmp",
  		dependencies = {
    			"hrsh7th/cmp-nvim-lsp",
    			"hrsh7th/cmp-buffer",
    			"hrsh7th/cmp-path",
    			"hrsh7th/cmp-cmdline",
			"rafamadriz/friendly-snippets",
    			"L3MON4D3/LuaSnip", -- Snippet engine
    			"saadparwaiz1/cmp_luasnip", -- Snippet completion source
  		},
		config = function()
			-- Require the necessary plugins
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Load any available VSCode-style snippets (optional)
require("luasnip.loaders.from_vscode").lazy_load()

-- Basic configuration for nvim-cmp
cmp.setup({
  snippet = {
    -- Specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body) -- Use LuaSnip
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection with Enter
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- LSP completions
    { name = "luasnip" }, -- Snippet completions
  }, {
    { name = "buffer" }, -- Buffer completions
    { name = "path" }, -- Path completions
  })
})

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

		end
	}
}
