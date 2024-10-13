return {
	{
	"hrsh7th/nvim-cmp",
    	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
	config = function()
		local cmp = require("cmp")

		cmp.setup({
			snippet = {
				expand = function(args)
            				require('luasnip').lsp_expand(args.body) -- For snippet support
        			end,
    			},
    mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'cmdline' },
    },
})
	end
	}
}
