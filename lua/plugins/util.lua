return {
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
    { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  },
	},
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-file-browser.nvim", lazy = true },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
			{ "nvim-lua/plenary.nvim" },
		},
		cmd = "Telescope",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
			{ "<leader>ft", "<cmd>Telescope live_grep<CR>", desc = "Find a string" },
			{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help" },
			{ "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Find keymaps" },
			{ "<leader>fgb", "<cmd>Telescope git_branches<CR>", desc = "Checkout branch" },
			{ "<leader>fb", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "File browser" },
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				pickers = {
					find_files = {
						theme = "dropdown",
						previewer = false,
						hidden = true,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
					file_browser = {
						theme = "dropdown", -- or "ivy"
						hidden = true, -- or "hide"
					},
				},
				defaults = {
					file_ignore_patterns = { "node_modules/", ".yarn/", ".git/", ".idea/" },
				},
			})
			telescope.load_extension("file_browser")
		end,
	},
	-- copilot - supermaven
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<C-l>",
					clear_suggestion = "<C-h>",
					accept_word = "<C-j>",
				},
				-- ignore_filetypes = { cpp = true }, -- or { "cpp", }
			})
		end,
	},
	-- null-ls
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			automatic_setup = true,
			ensure_installed = require("utils.formatters_linters"),
			automatic_installation = true,
		},
		dependencies = {
			{
				"nvimtools/none-ls.nvim",
				dependencies = "nvim-lua/plenary.nvim",
				keys = {
					{
						"<leader>lf",
						"<cmd>lua vim.lsp.buf.format{ async = true }<cr>",
						desc = "Format",
					},
				},
				config = function()
					local null_ls = require("null-ls")
					local formatting = null_ls.builtins.formatting
					-- local diagnostics = null_ls.builtins.diagnostics

					null_ls.setup({
						debug = false,
						sources = {
							formatting.prettier,
							formatting.stylua,
						},
					})
				end,
			},
		},
	},
	-- completion | nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-e>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
				}),
				window = {
					completion = {
						border = "rounded",
					},
					documentation = {
						border = "rounded",
					},
				},
				experimental = {
					ghost_text = false,
				},
			})
		end,
	},
	-- typescript
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		ft = { "typescript", "typescriptreact", "typescript.tsx" },
		config = function()
			require("typescript-tools").setup({
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
			})
		end,
	},
} -- finish
