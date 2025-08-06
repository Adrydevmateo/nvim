-- Plugin configurations
-- This file will be used to organize plugin specs in the future

local M = {}

-- Plugin specifications will be added here
-- Example structure:
-- M.plugins = {
--   {
--     "plugin/name",
--     config = function()
--       -- Plugin configuration
--     end,
--   },
-- }

M.plugins = {
  -- Kanagawa colorscheme
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false, -- Enable compilation for faster startup
        undercurl = true, -- Enable undercurl for spell checking
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- Set to true for transparent background
        dimInactive = false, -- Dim inactive windows
        terminalColors = true, -- Define vim.g.terminal_color_*
        colors = {
          palette = {
            -- Customize colors here
          },
          theme = {
            wave = {}, -- Default theme
            dragon = {}, -- Dragon theme
            lotus = {}, -- Lotus theme
            all = {
              ui = {
                bg_gutter = "none", -- Remove gutter background
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            -- Custom overrides
            Normal = { bg = "none" },
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            -- Make search highlighting more visible
            Search = { bg = theme.ui.bg_search, fg = theme.ui.fg_reverse },
            IncSearch = { bg = theme.ui.bg_search, fg = theme.ui.fg_reverse },
          }
        end,
        theme = "wave", -- Load "wave" theme when calling 'setup()'
        background = {
          dark = "wave", -- Dark theme
          light = "lotus", -- Light theme
        },
      })
      
      -- Set the colorscheme
      vim.cmd.colorscheme "kanagawa"
    end,
  },

  -- Floating terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- Size can be a number or function which is passed the current terminal
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]], -- Open terminal with Ctrl+\
        hide_numbers = true, -- Hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2, -- The degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- Whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = true, -- Close the terminal window when the process exits
        shell = vim.o.shell, -- Change the default shell
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
          -- The border key is *almost* the same as 'nvim_open_win'
          -- see :h nvim_open_win for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
          -- like `size`, width and height can be a number or function which is passed the current terminal
          width = function()
            return math.floor(vim.o.columns * 0.8)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.8)
          end,
          winblend = 3,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
  },

  -- File manager
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- Disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = "󰈚",
              symlink = "󰉒",
              folder = {
                default = "󰉋",
                empty = "󰉋",
                empty_open = "󰉋",
                open = "󰉋",
                symlink = "󰉒",
                symlink_open = "󰉒",
                arrow_open = "󰅇",
                arrow_closed = "󰅆",
              },
              git = {
                unstaged = "󰄱",
                staged = "✓",
                unmerged = "󰘬",
                renamed = "󰁕",
                untracked = "󰈔",
                deleted = "󰩺",
                ignored = "󰈝",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
          timeout = 400,
        },
        actions = {
          open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
              enable = true,
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            hint = "󰌵",
            info = "󰋼",
            warning = "󰅚",
            error = "󰅚",
          },
        },
      })
    end,
  },
}

return M
