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
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            -- Normal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            Normal = { fg = theme.ui.fg_dim },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
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

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    version = "*",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" }, -- Load on file read
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = {
          "c",
          "cpp",
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "python",
          "bash",
          "json",
          "yaml",
          "html",
          "css",
          "scss",
          "markdown",
          "toml",
          "rust",
          "go",
          "java",
          "php",
          "ruby",
          "sql",
          "xml",
          "dockerfile",
          "gitignore",
          "comment",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = {},

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          disable = {},

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true,
        },

        autotag = {
          enable = true,
        },

        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            scope_incremental = "<CR>",
            node_incremental = "<C-TAB>", -- Changed from <TAB> to avoid conflict
            node_decremental = "<S-TAB>",
          },
        },

        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>as"] = "@parameter.inner", -- Changed from <leader>a to avoid conflict
            },
            swap_previous = {
              ["<leader>aS"] = "@parameter.inner", -- Changed from <leader>A to avoid conflict
            },
          },
        },
      })
    end,
  },

  -- Performance monitoring
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Telescope for fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          file_ignore_patterns = {
            "node_modules",
            ".git",
            ".cache",
            "%.o",
            "%.a",
            "%.out",
            "%.class",
            "%.pdf",
            "%.mkv",
            "%.mp4",
            "%.zip",
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = false,
            no_ignore_parent = false,
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
          grep_string = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      -- Load extensions
      pcall(telescope.load_extension, "fzf")

      -- Telescope keymaps
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
      map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
      map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
      map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
      map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", opts)
      map("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", opts)
      map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", opts)
      map("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", opts)
      map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", opts)
      map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", opts)
      map("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", opts)
      map("n", "<leader>fS", "<cmd>Telescope lsp_document_symbols<cr>", opts)
      map("n", "<leader>fw", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)
    end,
  },

  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- LSP keymaps
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- LSP keymaps
      map("n", "gd", vim.lsp.buf.definition, opts)
      map("n", "gr", vim.lsp.buf.references, opts)
      map("n", "gi", vim.lsp.buf.implementation, opts)
      map("n", "K", vim.lsp.buf.hover, opts)
      map("n", "<leader>rn", vim.lsp.buf.rename, opts)
      map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      map("n", "<leader>lf", vim.lsp.buf.format, opts) -- Changed from <leader>f to avoid conflict with Telescope
      map("n", "<leader>d", vim.diagnostic.open_float, opts)
      map("n", "[d", vim.diagnostic.goto_prev, opts)
      map("n", "]d", vim.diagnostic.goto_next, opts)

      -- LSP settings
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Performance-optimized LSP diagnostic configuration
      vim.diagnostic.config({
        virtual_text = false, -- Disable inline diagnostics for better performance
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- LSP signs with minimal icons
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Performance-optimized Rust LSP configuration
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150, -- Debounce text changes for better performance
        },
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              enable = true,
              command = "check", -- Use 'check' instead of 'clippy' for faster analysis
            },
            cargo = {
              allFeatures = false, -- Disable all features for faster loading
              loadOutDirsFromCheck = true,
              runBuildScripts = false, -- Disable build scripts for faster startup
              buildScripts = {
                enable = false,
              },
            },
            diagnostics = {
              enable = true,
              disabled = {
                "unresolved-proc-macro",
                "missing-unsafe",
              },
            },
            inlayHints = {
              enable = false, -- Disable inlay hints for better performance
            },
            lens = {
              enable = false, -- Disable code lens for better performance
            },
            hover = {
              enable = true,
              actions = {
                enable = false, -- Disable hover actions for better performance
              },
            },
            completion = {
              enable = true,
              autoimport = {
                enable = true,
              },
            },
            assist = {
              enable = true,
              emitMustUse = false, -- Disable must-use warnings for better performance
              importGranularity = "module",
              importPrefix = "self",
            },
            callInfo = {
              enable = false, -- Disable call info for better performance
            },
            procMacro = {
              enable = true,
            },
            workspace = {
              symbol = {
                search = {
                  kind = "only_types", -- Limit symbol search to types only
                },
              },
            },
          },
        },
      })

      -- Performance optimizations for LSP
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        max_width = 80,
        max_height = 20,
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        max_width = 80,
      })
    end,
  },

  -- Mason for LSP installation (lazy loaded)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        -- Performance optimizations
        max_concurrent_installers = 1, -- Limit concurrent installations
        install_root_dir = vim.fn.stdpath("data") .. "/mason",
      })
    end,
  },

  -- Mason LSP config (lazy loaded)
  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "rust_analyzer",
        },
        automatic_installation = false, -- Disable automatic installation for better performance
      })
    end,
  },

  -- Supermaven AI code completion
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-Tab>", -- Changed from <Tab> to avoid conflict with completion
          clear_suggestion = "<C-]>",
          accept_word = "<C-l>", -- Changed from <C-j> to avoid conflict with Telescope
        },
        ignore_filetypes = {}, -- No ignored filetypes
        color = {
          suggestion_color = "#6CC644", -- Supermaven green color
          cterm = 244,
        },
        log_level = "info",
        disable_inline_completion = false,
        disable_keymaps = false,
        condition = function()
          return false -- Always enable Supermaven
        end,
      })
    end,
  },

  -- Completion (lazy loaded on insert)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load friendly snippets lazily
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              -- Let Supermaven handle Tab if no other completion is active
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
        },
        sources = {
          { name = "supermaven", priority = 1500 }, -- Supermaven with highest priority
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        },
        formatting = {
          format = function(entry, item)
            item.menu = ({
              supermaven = "[AI]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return item
          end,
        },
        -- Performance optimizations
        completion = {
          completeopt = "menuone,noselect,noinsert",
        },
        window = {
          completion = {
            border = "rounded",
            col_offset = -3,
            side_padding = 0,
          },
          documentation = {
            border = "rounded",
          },
        },
        experimental = {
          ghost_text = false, -- Disable ghost text for better performance
        },
      })
    end,
  },
}

return M
