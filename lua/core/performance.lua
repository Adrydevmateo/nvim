-- Performance optimizations for Neovim
-- Disable built-in plugins and optimize settings for speed

local M = {}

-- Disable built-in plugins for better performance
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

function M.setup()
  -- Disable built-in plugins
  for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
  end

  -- Performance optimizations
  vim.opt.updatetime = 100 -- Faster completion
  vim.opt.timeoutlen = 300 -- Faster key sequence completion
  vim.opt.redrawtime = 1500 -- Allow more time for loading syntax
  vim.opt.synmaxcol = 240 -- Only highlight the first 240 columns
  vim.opt.maxmempattern = 1000 -- Limit the memory used for pattern matching
end

return M
