return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 100,
		config = function()
			require("kanagawa").setup({
				undercurl = true,
				commentStyle = { italic = true },
				functionStyle = { italic = true },
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = { bold = true },
				transparent_background = false,
				overrides = function(colors)
					local theme = colors.theme
					local makeDiagnosticColor = function(color)
						local c = require("kanagawa.lib.color")
						return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
					end

					return {
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },
						NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

						-- Borderless Telescope
						-- TelescopeTitle = { fg = theme.ui.special, bold = true },
						-- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
						-- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
						-- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
						-- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
						-- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
						-- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

						-- Dark completion (popup) menu
						Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p2 },

						-- Tint background of diagnostic messages with their foreground color
						DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
						DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
						DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
						DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
					}
				end,
			})
			vim.cmd.colorscheme("kanagawa-wave")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 100,
		lazy = false,
		config = function()
			require("rose-pine").setup({
				dark_variant = "main", -- main, moon, or dawn
				styles = {
					bold = true,
					italic = true,
					transparency = true,
				},
			})

			-- vim.cmd.colorscheme "rose-pine"
		end,
	},
}
