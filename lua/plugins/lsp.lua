local utils = require("core.utils")

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "j-hui/fidget.nvim", -- LSP status updates
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = utils.mason_servers,
      })

      -- lsp config
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local km = vim.keymap.set

      -- add additional capabilities supported by nvim-cmp
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- enable language servers (excluding rust_analyzer which is handled by rustaceanvim)
      local servers = utils.mason_servers
      for _, lsp in ipairs(servers) do
        if lsp ~= "rust_analyzer" then
          lspconfig[lsp].setup {
            capabilities = capabilities,
          }
        end
      end

      -- lua lsp config
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            format = {
              enable = true,
              -- format options
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
              },
            },
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false }
          }
        },
        on_attach = function(_, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          km("n", "gD", vim.lsp.buf.declaration, bufopts)
          km("n", "gd", vim.lsp.buf.definition, bufopts)
          km("n", "K", vim.lsp.buf.hover, bufopts)
          km("n", "gi", vim.lsp.buf.implementation, bufopts)
          km("n", "<space-k>", vim.lsp.buf.signature_help, bufopts)
          km("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          km("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          km("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
          km("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
          km("n", "gr", vim.lsp.buf.references, bufopts)
          km(
            "n",
            "<space>wl",
            function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            bufopts
          )
          km(
            "n",
            "<space>f",
            function()
              vim.lsp.buf.format {
                async = true
              }
            end,
            bufopts
          )
        end,
      }

      -- go lsp config
      lspconfig.gopls.setup {
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
        on_attach = function(_, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          km("n", "gD", vim.lsp.buf.declaration, bufopts)
          km("n", "gd", vim.lsp.buf.definition, bufopts)
          km("n", "K", vim.lsp.buf.hover, bufopts)
          km("n", "gi", vim.lsp.buf.implementation, bufopts)
          km("n", "<space-k>", vim.lsp.buf.signature_help, bufopts)
          km("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          km("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          km("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
          km("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
          km("n", "gr", vim.lsp.buf.references, bufopts)
          km(
            "n",
            "<space>wl",
            function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            bufopts
          )
          km(
            "n",
            "<space>f",
            function()
              vim.lsp.buf.format {
                async = true
              }
            end,
            bufopts
          )
        end,
      }

      -- typescript/javascript lsp config
      lspconfig.ts_ls.setup {
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
        on_attach = function(_, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          km("n", "gD", vim.lsp.buf.declaration, bufopts)
          km("n", "gd", vim.lsp.buf.definition, bufopts)
          km("n", "K", vim.lsp.buf.hover, bufopts)
          km("n", "gi", vim.lsp.buf.implementation, bufopts)
          km("n", "<space-k>", vim.lsp.buf.signature_help, bufopts)
          km("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          km("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          km("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
          km("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
          km("n", "gr", vim.lsp.buf.references, bufopts)
          km(
            "n",
            "<space>wl",
            function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            bufopts
          )
          km(
            "n",
            "<space>f",
            function()
              vim.lsp.buf.format {
                async = true
              }
            end,
            bufopts
          )
        end,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      }

      -- biome lsp config
      lspconfig.biome.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "json",
          "jsonc"
        },
        root_dir = lspconfig.util.root_pattern("biome.json", ".biome.json", "package.json", ".git"),
        single_file_support = true,
        on_attach = function(_, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          km("n", "gD", vim.lsp.buf.declaration, bufopts)
          km("n", "gd", vim.lsp.buf.definition, bufopts)
          km("n", "K", vim.lsp.buf.hover, bufopts)
          km("n", "gi", vim.lsp.buf.implementation, bufopts)
          km("n", "<space-k>", vim.lsp.buf.signature_help, bufopts)
          km("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          km("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          km("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
          km("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
          km("n", "gr", vim.lsp.buf.references, bufopts)
          km(
            "n",
            "<space>wl",
            function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            bufopts
          )
          km(
            "n",
            "<space>f",
            function()
              vim.lsp.buf.format {
                async = true
              }
            end,
            bufopts
          )
        end,
      })

      -- global mappings
      km("n", "<space>e", vim.diagnostic.open_float)
      km("n", "[d", vim.diagnostic.goto_prev)
      km("n", "]d", vim.diagnostic.goto_next)
      km("n", "<space>q", vim.diagnostic.setloclist)

      -- setup nvim-cmp
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace, select = true,
          },
          ["<Tab>"] = cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end,
            { "i", "s" }
          ),
          ["<S-Tab>"] = cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end,
            { "i", "s" }
          ),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })

      -- lsp status updates
      require("fidget").setup()
    end,
  },
}
