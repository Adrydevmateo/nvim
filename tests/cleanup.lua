-- Cleanup script for Neovim configuration
-- Run this in Neovim with: :lua dofile("tests/cleanup.lua")

local function cleanup_plugins()
  print("🧹 Starting plugin cleanup...")
  
  -- Clean Lazy cache
  print("Cleaning Lazy cache...")
  vim.cmd("Lazy clean")
  
  -- Force reload of problematic plugins
  print("Reloading plugins...")
  vim.cmd("Lazy sync")
  
  print("✅ Cleanup complete! Please restart Neovim.")
end

-- Function to check plugin versions
local function check_plugin_versions()
  print("🔍 Checking plugin versions...")
  
  local plugins = {
    "indent-blankline.nvim",
    "nvim-treesitter",
    "lualine.nvim",
    "which-key.nvim"
  }
  
  for _, plugin in ipairs(plugins) do
    local ok, _ = pcall(require, plugin:gsub("%.nvim", ""))
    if ok then
      print("✅ " .. plugin .. " loaded successfully")
    else
      print("❌ " .. plugin .. " failed to load")
    end
  end
end

-- Function to reset indent-blankline specifically
local function reset_indent_blankline()
  print("🔄 Resetting indent-blankline...")
  
  -- Try to unload the plugin
  local ok, _ = pcall(function()
    package.loaded.indent_blankline = nil
  end)
  
  if ok then
    print("✅ indent-blankline unloaded")
  else
    print("❌ Failed to unload indent-blankline")
  end
end

-- Main cleanup function
local function main()
  print("🚀 Neovim Configuration Cleanup")
  print("================================")
  
  reset_indent_blankline()
  check_plugin_versions()
  cleanup_plugins()
  
  print("\n📝 Next steps:")
  print("1. Restart Neovim")
  print("2. Run :checkhealth")
  print("3. Check :Lazy log for any remaining issues")
end

-- Run cleanup
main() 