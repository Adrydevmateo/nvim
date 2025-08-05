return {
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    lazy = false, -- This plugin is already lazy-loaded by default
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          -- rust-tools options
          hover_actions = {
            -- whether the hover action window gets automatically focused
            auto_focus = true,
          },
        },
        -- LSP configuration
        server = {
          on_attach = function(_, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            local km = vim.keymap.set
            
            -- LSP keymaps
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
            km("n", "<space>f", function()
              vim.lsp.buf.format { async = true }
            end, bufopts)
            
            -- Rust-specific keymaps
            km("n", "<leader>rr", "<cmd>RustLsp runnables<CR>", bufopts)
            km("n", "<leader>rt", "<cmd>RustLsp testables<CR>", bufopts)
            km("n", "<leader>rd", "<cmd>RustLsp debuggables<CR>", bufopts)
            km("n", "<leader>rh", "<cmd>RustLsp hover actions<CR>", bufopts)
            km("n", "<leader>rm", "<cmd>RustLsp expand macro<CR>", bufopts)
            km("n", "<leader>rc", "<cmd>RustLsp open cargo<CR>", bufopts)
            km("n", "<leader>rp", "<cmd>RustLsp parent module<CR>", bufopts)
            km("n", "<leader>rj", "<cmd>RustLsp join lines<CR>", bufopts)
            km("n", "<leader>rs", "<cmd>RustLsp syntax tree<CR>", bufopts)
            km("n", "<leader>rw", "<cmd>RustLsp reload workspace<CR>", bufopts)
          end,
          settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add any other rust-analyzer settings here
              procMacro = {
                enable = true,
              },
              checkOnSave = {
                command = "clippy",
              },
              inlayHints = {
                enable = true,
                showParameterHints = true,
                showTypeHints = true,
                showChainingHints = true,
                showOtherHints = true,
              },
            },
          },
        },
        -- DAP configuration
        dap = {
          adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
          },
        },
      }
    end,
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        popup = {
          border = "rounded",
        },
        src = {
          cmp = { enabled = true },
        },
      })
    end,
  },
} 