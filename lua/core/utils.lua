local M = {}

M.treesitter_languages = {
  "go",
  "astro",
  "typescript",
  "rust",
  "lua",
  "javascript",
  "json",
  "yaml",
  "toml",
  "markdown",
  "bash",
  "python",
  "html",
  "css",
  "scss",
  "sql",
  "dockerfile",
  "gitignore",
  "gitcommit",
}

M.mason_servers = {
  "lua_ls",
  "gopls",
  "ts_ls",
  "biome",
  "rust_analyzer",
  "pyright",
  "yamlls",
  "jsonls",
  "html",
  "cssls",
  "emmet_ls",
  "dockerls",
  "bashls",
}

-- Performance optimization settings
M.performance_settings = {
  -- LSP performance
  lsp = {
    debounce_text_changes = 150,
    max_file_size = 1000000, -- 1MB
  },
  -- Treesitter performance
  treesitter = {
    max_file_size = 500000, -- 500KB
    disable_languages = { "latex" }, -- Disable for heavy languages
  },
  -- Telescope performance
  telescope = {
    max_results = 1000,
    preview_cutoff = 100,
  },
}

-- File type specific settings
M.filetype_settings = {
  -- Go specific
  go = {
    format_on_save = true,
    test_on_save = false,
  },
  -- Rust specific
  rust = {
    format_on_save = true,
    check_on_save = true,
  },
  -- TypeScript/JavaScript specific
  typescript = {
    format_on_save = true,
    organize_imports = true,
  },
  javascript = {
    format_on_save = true,
    organize_imports = true,
  },
  -- Lua specific
  lua = {
    format_on_save = true,
  },
}

-- Utility functions
function M.is_large_file()
  local line_count = vim.api.nvim_buf_line_count(0)
  return line_count > 10000
end

function M.is_git_repo()
  local git_dir = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
  return git_dir ~= ""
end

function M.get_project_root()
  local patterns = { ".git", "package.json", "Cargo.toml", "go.mod", "pyproject.toml" }
  for _, pattern in ipairs(patterns) do
    local found = vim.fn.finddir(pattern, vim.fn.getcwd() .. ";")
    if found ~= "" then
      return vim.fn.fnamemodify(found, ":h")
    end
  end
  return vim.fn.getcwd()
end

function M.setup_autocmds()
  -- Auto-resize splits when window is resized
  vim.api.nvim_create_autocmd("VimResized", {
    callback = function()
      vim.cmd("tabdo wincmd =")
    end,
  })

  -- Highlight on yank
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
    end,
  })

  -- Auto-save on focus lost
  vim.api.nvim_create_autocmd("FocusLost", {
    callback = function()
      if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" then
        vim.cmd("silent! write")
      end
    end,
  })

  -- Return to last edit position when opening files
  vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
      local last_pos = vim.fn.line("'\"")
      if last_pos > 0 and last_pos <= vim.fn.line("$") then
        vim.fn.setpos(".", vim.fn.getpos("'\""))
      end
    end,
  })

  -- Auto-format on save for specific file types
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go", "*.rs", "*.ts", "*.tsx", "*.js", "*.jsx", "*.lua" },
    callback = function()
      if M.filetype_settings[vim.bo.filetype] and M.filetype_settings[vim.bo.filetype].format_on_save then
        vim.lsp.buf.format({ async = false })
      end
    end,
  })
end

return M
