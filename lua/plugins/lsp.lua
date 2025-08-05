local utils = require("core.utils")

-- Common LSP keymaps function
local function setup_lsp_keymaps(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local km = vim.keymap.set
  
  -- LSP keymaps
  km("n", "gD", vim.lsp.buf.declaration, bufopts)
  km("n", "gd", vim.lsp.buf.definition, bufopts)
  km("n", "K", vim.lsp.buf.hover, bufopts)
  km("n", "gi", vim.lsp.buf.implementation, bufopts)
  km("n", "<space>k", vim.lsp.buf.signature_help, bufopts)
  km("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  km("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  km("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  km("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  km("n", "gr", vim.lsp.buf.references, bufopts)
  km("n", "<space>f", function()
    vim.lsp.buf.format { async = true }
  end, bufopts)
  
  -- Show workspace folders
  km("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  
  -- Rename symbol
  km("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  
  -- Show diagnostics
  km("n", "<space>e", vim.diagnostic.open_float, bufopts)
end

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
      "j-hui/fidget.nvim",
    },
    config = function()
      -- Mason setup
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
      
      require("mason-lspconfig").setup({
        ensure_installed = utils.mason_servers,
        automatic_installation = true,
      })

      -- LSP config
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local km = vim.keymap.set

      -- Enhanced capabilities
      local capabilities = cmp_nvim_lsp.default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      }

      -- Global LSP keymaps
      km("n", "<space>e", vim.diagnostic.open_float)
      km("n", "[d", vim.diagnostic.goto_prev)
      km("n", "]d", vim.diagnostic.goto_next)
      km("n", "<space>q", vim.diagnostic.setloclist)

      -- Setup language servers
      local servers = utils.mason_servers
      for _, lsp in ipairs(servers) do
        if lsp ~= "rust_analyzer" then
          local ok, _ = pcall(function()
            lspconfig[lsp].setup {
              capabilities = capabilities,
              on_attach = setup_lsp_keymaps,
            }
          end)
          if not ok then
            vim.notify("Failed to setup LSP for " .. lsp, vim.log.levels.WARN)
          end
        end
      end

      -- Lua LSP specific config
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        on_attach = setup_lsp_keymaps,
        settings = {
          Lua = {
            format = {
              enable = true,
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
              },
            },
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { 
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
            hint = {
              enable = true,
            },
          }
        },
      }

      -- Go LSP specific config
      lspconfig.gopls.setup {
        capabilities = capabilities,
        on_attach = setup_lsp_keymaps,
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
            usePlaceholders = true,
            completeUnimported = true,
            memoryMode = "DegradeClosed",
          },
        },
      }

      -- TypeScript/JavaScript LSP config
      lspconfig.ts_ls.setup {
        capabilities = capabilities,
        on_attach = setup_lsp_keymaps,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
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
            suggest = {
              completeFunctionCalls = true,
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
            suggest = {
              completeFunctionCalls = true,
            },
          },
        },
      }

      -- Biome LSP config
      lspconfig.biome.setup({
        capabilities = capabilities,
        on_attach = setup_lsp_keymaps,
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
      })

      -- Setup nvim-cmp
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
            behavior = cmp.ConfirmBehavior.Replace, 
            select = true,
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
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s", vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })

      -- LSP status updates
      require("fidget").setup({
        notification = {
          window = {
            winblend = 0,
          },
        },
      })
    end,
  },
}
