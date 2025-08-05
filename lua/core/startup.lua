local M = {}

-- Error handling function
function M.safe_require(module_name)
  local ok, module = pcall(require, module_name)
  if not ok then
    vim.notify("Failed to load module: " .. module_name, vim.log.levels.ERROR)
    return nil
  end
  return module
end

-- Initialize core modules safely
function M.init()
  -- Load core modules with error handling
  local modules = {
    "core.globals",
    "core.keymaps", 
    "core.options",
    "core.lazy",
  }
  
  for _, module in ipairs(modules) do
    local ok, _ = pcall(require, module)
    if not ok then
      vim.notify("Failed to load core module: " .. module, vim.log.levels.ERROR)
    end
  end
  
  -- Setup utility functions
  local utils = M.safe_require("core.utils")
  if utils then
    utils.setup_autocmds()
  end
end

-- Check for common issues
function M.check_health()
  local issues = {}
  
  -- Check if ripgrep is available for Telescope
  if vim.fn.executable("rg") == 0 then
    table.insert(issues, "ripgrep (rg) not found. Install it for better Telescope performance.")
  end
  
  -- Check if fd is available for file finding
  if vim.fn.executable("fd") == 0 then
    table.insert(issues, "fd not found. Install it for better file finding.")
  end
  
  -- Check for Nerd Fonts
  if vim.fn.has("gui_running") == 1 then
    local font = vim.opt.guifont:get()
    if font and not string.find(font, "Nerd") then
      table.insert(issues, "Consider installing a Nerd Font for better icon support.")
    end
  end
  
  if #issues > 0 then
    vim.notify("Health check issues found:\n" .. table.concat(issues, "\n"), vim.log.levels.WARN)
  end
end

return M 