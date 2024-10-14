return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = true,
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<C-\>]],
				direction = "float",
			})
		end,
	},
	-- Add formatter.nvim
	{
		"mhartington/formatter.nvim",
		config = function()
			-- Set up formatter.nvim configuration here
			require("formatter").setup({
				-- Enable formatting for specific filetypes
				filetype = {
					lua = {
						-- Use stylua for formatting Lua files
						function()
							return {
								exe = "stylua",
								args = { "--search-parent-directories", "-" },
								stdin = true,
							}
						end,
					},
					-- Add other filetypes as needed
				},
			})

			-- Auto-format on save for Lua files
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.lua",
				command = "FormatWrite",
			})
		end,
	},
}
