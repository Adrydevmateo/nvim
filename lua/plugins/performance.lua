return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufReadPre",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        throttle = true,
        max_lines = 0,
        patterns = {
          default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  },
  {
    "folke/twilight.nvim",
    opts = {
      dimming = {
        alpha = 0.25,
        active = true,
      },
      context = 10,
      treesitter = true,
      expand = {
        "function",
        "method",
        "table",
        "if_statement",
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>b"] = { name = "+buffers" },
        ["<leader>t"] = { name = "+tabs" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>l"] = { name = "+lsp" },
        ["<leader>e"] = { name = "+edit" },
        ["<leader>s"] = { name = "+source" },
        ["<leader>c"] = { name = "+clipboard" },
        ["<leader>d"] = { name = "+delete" },
        ["<leader>y"] = { name = "+yank" },
        ["<leader>p"] = { name = "+paste" },
        ["<space>f"] = { name = "+find" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      
      -- Register keymaps with descriptions
      wk.register({
        -- Window management
        ["<leader>wv"] = { "<C-w>v", "Split vertically" },
        ["<leader>ws"] = { "<C-w>s", "Split horizontally" },
        ["<leader>wc"] = { "<C-w>c", "Close window" },
        ["<leader>wo"] = { "<C-w>o", "Close other windows" },
        ["<leader>w"] = { ":w<CR>", "Save file" },
        
        -- Buffer navigation
        ["<leader>bn"] = { ":bnext<CR>", "Next buffer" },
        ["<leader>bp"] = { ":bprevious<CR>", "Previous buffer" },
        ["<leader>bd"] = { ":bdelete<CR>", "Delete buffer" },
        ["<leader>ba"] = { ":bufdo bdelete<CR>", "Delete all buffers" },
        
        -- Tab navigation
        ["<leader>tn"] = { ":tabnew<CR>", "New tab" },
        ["<leader>tc"] = { ":tabclose<CR>", "Close tab" },
        ["<leader>to"] = { ":tabonly<CR>", "Close other tabs" },
        ["<leader>th"] = { ":tabprevious<CR>", "Previous tab" },
        ["<leader>tl"] = { ":tabnext<CR>", "Next tab" },
        
        -- Quick actions
        ["<leader>q"] = { ":q<CR>", "Quit" },
        ["<leader>Q"] = { ":qa!<CR>", "Quit all" },
        ["<leader><CR>"] = { ":nohlsearch<CR>", "Clear search highlights" },
        
        -- Edit config
        ["<leader>ev"] = { ":e $MYVIMRC<CR>", "Edit vimrc" },
        ["<leader>sv"] = { ":source $MYVIMRC<CR>", "Source vimrc" },
        
        -- Toggle options
        ["<leader>tw"] = { ":set wrap!<CR>", "Toggle wrap" },
        ["<leader>tN"] = { ":set number!<CR>", "Toggle line numbers" },
        ["<leader>tr"] = { ":set relativenumber!<CR>", "Toggle relative numbers" },
        ["<leader>tL"] = { ":set list!<CR>", "Toggle list mode" },
        
        -- File operations
        ["<leader>cd"] = { ":cd %:p:h<CR>", "Change to file directory" },
        ["<leader>pwd"] = { ":pwd<CR>", "Show current directory" },
        
        -- Clipboard operations
        ["<leader>y"] = { '"+y', "Yank to clipboard" },
        ["<leader>Y"] = { '"+yg_', "Yank line to clipboard" },
        ["<leader>p"] = { '"+p', "Paste from clipboard" },
        ["<leader>P"] = { '"+P', "Paste before cursor" },
        ["<leader>d"] = { '"_d', "Delete without yanking" },
        ["<leader>c"] = { '"_c', "Change without yanking" },
        
        -- Help
        ["<leader>h"] = { ":help ", "Help" },
        ["<leader>H"] = { ":help", "Help index" },
        
        -- Telescope keymaps
        ["<space>ff"] = { "<cmd>Telescope find_files<CR>", "Find files" },
        ["<space>fg"] = { "<cmd>Telescope live_grep<CR>", "Live grep" },
        ["<space>fb"] = { "<cmd>Telescope buffers<CR>", "Buffers" },
        ["<space>fh"] = { "<cmd>Telescope help_tags<CR>", "Help tags" },
        ["<space>fo"] = { "<cmd>Telescope oldfiles<CR>", "Old files" },
        ["<space>fc"] = { "<cmd>Telescope git_commits<CR>", "Git commits" },
        ["<space>fs"] = { "<cmd>Telescope git_status<CR>", "Git status" },
        
        -- Terminal keymaps
        ["<leader>tt"] = { "<cmd>ToggleTerm<CR>", "Toggle terminal" },
        ["<leader>tf"] = { "<cmd>ToggleTerm direction=float<CR>", "Float terminal" },
        
        -- LSP keymaps
        ["gd"] = { vim.lsp.buf.definition, "Go to definition" },
        ["gD"] = { vim.lsp.buf.declaration, "Go to declaration" },
        ["gr"] = { vim.lsp.buf.references, "Go to references" },
        ["gi"] = { vim.lsp.buf.implementation, "Go to implementation" },
        ["K"] = { vim.lsp.buf.hover, "Hover documentation" },
        ["<space>k"] = { vim.lsp.buf.signature_help, "Signature help" },
        ["<space>ca"] = { vim.lsp.buf.code_action, "Code action" },
        ["<space>rn"] = { vim.lsp.buf.rename, "Rename symbol" },
        ["<space>f"] = { function() vim.lsp.buf.format { async = true } end, "Format document" },
        ["<space>e"] = { vim.diagnostic.open_float, "Show diagnostics" },
        ["[d"] = { vim.diagnostic.goto_prev, "Previous diagnostic" },
        ["]d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
      }, { mode = "n" })
      
      -- Visual mode keymaps
      wk.register({
        ["<leader>y"] = { '"+y', "Yank to clipboard" },
        ["<leader>p"] = { '"+p', "Paste from clipboard" },
        ["<leader>P"] = { '"+P', "Paste before cursor" },
        ["<leader>d"] = { '"_d', "Delete without yanking" },
        ["<leader>c"] = { '"_c', "Change without yanking" },
      }, { mode = "v" })
      
      -- Register defaults
      wk.register(opts.defaults)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
              newfile = "[New]",
            },
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "nvim-tree", "telescope", "toggleterm" },
    },
  },
  -- Temporarily disabled due to version conflicts
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   version = "^3.0",
  --   event = "BufReadPre",
  --   config = function()
  --     require("indent_blankline").setup({
  --       char = "│",
  --       filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
  --       show_trailing_blankline_indent = false,
  --       show_current_context = false,
  --       show_current_context_start = false,
  --     })
  --   end,
  -- },
  {
    "echasnovski/mini.indentscope",
    version = false,
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
} 