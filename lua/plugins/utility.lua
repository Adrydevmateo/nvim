return {
  {
    "supermaven-inc/supermaven-nvim",
    lazy = false,
    config = function()
      require("supermaven-nvim").setup({
        -- Performance optimizations
        max_tokens = 1000,
        temperature = 0.1,
        top_p = 0.95,
        -- Disable for large files to improve performance
        disable_for_files_larger_than = 100000,
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<C-n>", function() require("nvim-tree.api").tree.toggle() end, desc = "Toggle NvimTree" },
    },
    config = function()
      local ok, nvim_tree = pcall(require, "nvim-tree")
      if not ok then
        vim.notify("Failed to load nvim-tree", vim.log.levels.ERROR)
        return
      end
      
      nvim_tree.setup {
        sort = { sorter = "case_sensitive" },
        filters = {
          dotfiles = true,
          git_ignored = true,
        },
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
        },
        view = {
          adaptive_size = true,
          centralize_selection = true,
          width = 30,
          side = "left",
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
            git_placement = "before",
          },
        },
        actions = {
          open_file = {
            resize_window = true,
          },
        },
        -- Performance optimizations
        update_focused_file = {
          enable = true,
          update_cwd = false,
        },
        diagnostics = {
          enable = true,
          show_on_dirs = false,
          icons = {
            hint = "󰠠",
            info = "󰋼",
            warning = "󰅚",
            error = "󰅚",
          },
        },
      }
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
      { "<C-\\>", mode = "n", desc = "Toggle terminal" },
      { "<leader>tt", mode = "n", desc = "Toggle terminal" },
      { "<leader>tf", mode = "n", desc = "Float terminal" },
    },
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
        insert_mappings = true,
        terminal_mappings = true,
        direction = "float",
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        -- Performance optimizations
        persist_mode = true,
        auto_scroll = true,
        close_on_exit = true,
        shell = vim.o.shell,
        auto_insert = true,
      })
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      -- This plugin will be loaded by telescope automatically
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false, -- Load immediately so commands are available
    keys = {
      { "<space>ff", mode = "n", desc = "Telescope find files" },
      { "<space>fg", mode = "n", desc = "Telescope live grep" },
      { "<space>fb", mode = "n", desc = "Telescope buffers" },
      { "<space>fh", mode = "n", desc = "Telescope help tags" },
      { "<space>fo", mode = "n", desc = "Telescope old files" },
      { "<space>fc", mode = "n", desc = "Telescope git commits" },
      { "<space>fs", mode = "n", desc = "Telescope git status" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local builtin = require("telescope.builtin")
      local telescope = require("telescope")
      local km = vim.keymap.set

      -- Keymaps
      km("n", "<space>ff", builtin.find_files, { desc = "Telescope find files" })
      km("n", "<space>fg", builtin.live_grep, { desc = "Telescope live grep" })
      km("n", "<space>fb", builtin.buffers, { desc = "Telescope buffers" })
      km("n", "<space>fh", builtin.help_tags, { desc = "Telescope help tags" })
      km("n", "<space>fo", builtin.oldfiles, { desc = "Telescope old files" })
      km("n", "<space>fc", builtin.git_commits, { desc = "Telescope git commits" })
      km("n", "<space>fs", builtin.git_status, { desc = "Telescope git status" })

      -- Register Telescope commands
      vim.api.nvim_create_user_command("Telescope", function(args)
        local cmd = args.args
        if cmd == "find_files" then
          builtin.find_files()
        elseif cmd == "live_grep" then
          builtin.live_grep()
        elseif cmd == "buffers" then
          builtin.buffers()
        elseif cmd == "help_tags" then
          builtin.help_tags()
        elseif cmd == "oldfiles" then
          builtin.oldfiles()
        elseif cmd == "git_commits" then
          builtin.git_commits()
        elseif cmd == "git_status" then
          builtin.git_status()
        else
          print("Available Telescope commands: find_files, live_grep, buffers, help_tags, oldfiles, git_commits, git_status")
        end
      end, { nargs = 1, complete = function()
        return { "find_files", "live_grep", "buffers", "help_tags", "oldfiles", "git_commits", "git_status" }
      end })

      -- Telescope configuration
      telescope.setup({
        defaults = {
          prompt_prefix = "  ",
          selection_caret = "  ",
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/*",
          },
          file_ignore_patterns = {
            "node_modules",
            ".git",
            "dist",
            "build",
            "target",
            "*.lock",
            "*.log",
            ".vite",
            ".next",
            ".nuxt",
            ".output",
            "coverage",
            ".nyc_output",
            ".cache",
            ".parcel-cache",
          },
          path_display = { "truncate" },
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          color_devicons = true,
          set_env = { COLORTERM = "truecolor" },
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--exclude", "node_modules" },
            hidden = true,
            no_ignore = false,
            follow = true,
            file_ignore_patterns = {
              "node_modules",
              ".git",
              "dist",
              "build",
              ".vite",
              ".next",
              ".nuxt",
              ".output",
              "coverage",
              ".nyc_output",
              ".cache",
              ".parcel-cache",
            },
          },
          live_grep = {
            additional_args = function()
              return { "--hidden", "--glob=!node_modules/*", "--glob=!.git/*" }
            end,
            file_ignore_patterns = {
              "node_modules",
              ".git",
              "dist",
              "build",
              ".vite",
              ".next",
              ".nuxt",
              ".output",
              "coverage",
              ".nyc_output",
              ".cache",
              ".parcel-cache",
            },
          },
          buffers = {
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              },
            },
          },
        },
        extensions = {},
      })

      -- Load extensions with better error handling
      local extensions = {
        fzf = {
          name = "fzf",
          message = "FZF extension not available. Install telescope-fzf-native.nvim for better performance.",
          config = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        },
        file_browser = {
          name = "file_browser",
          message = "File browser extension not available. Install telescope-file-browser.nvim for file browsing.",
          config = {
            theme = "dropdown",
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                ["<C-w>"] = function()
                  vim.cmd("normal vbd")
                end,
              },
              ["n"] = {
                ["N"] = require("telescope").extensions.file_browser.actions.create,
                ["h"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
                ["/"] = function()
                  vim.cmd("startinsert")
                end,
              },
            },
          }
        }
      }
      
      for _, ext in pairs(extensions) do
        local ok, _ = pcall(function()
          telescope.load_extension(ext.name)
        end)
        if not ok then
          vim.notify(ext.message, vim.log.levels.WARN)
        else
          vim.notify(ext.name .. " extension loaded successfully", vim.log.levels.INFO)
        end
      end
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })
    end,
  },
}
