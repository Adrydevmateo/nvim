-- Test script for Telescope configuration
-- Run this in Neovim with: :lua dofile("tests/test_telescope.lua")

local function test_telescope()
  print("🔍 Testing Telescope configuration...")
  
  -- Test if telescope can be loaded
  local ok, telescope = pcall(require, "telescope")
  if not ok then
    print("❌ Failed to load telescope")
    return false
  end
  
  print("✅ Telescope loaded successfully")
  
  -- Test if builtin functions are available
  local builtin_ok, builtin = pcall(require, "telescope.builtin")
  if not builtin_ok then
    print("❌ Failed to load telescope.builtin")
    return false
  end
  
  print("✅ Telescope builtin functions available")
  
  -- Test extensions
  local extensions = {
    "fzf",
    "file_browser"
  }
  
  for _, ext_name in ipairs(extensions) do
    local ext_ok, _ = pcall(function()
      telescope.load_extension(ext_name)
    end)
    
    if ext_ok then
      print("✅ " .. ext_name .. " extension loaded successfully")
    else
      print("❌ " .. ext_name .. " extension failed to load")
    end
  end
  
  return true
end

local function test_keymaps()
  print("\n⌨️ Testing Telescope keymaps...")
  
  local keymaps_to_test = {
    "<space>ff",
    "<space>fg", 
    "<space>fb",
    "<space>fh",
    "<space>fo",
    "<space>fc",
    "<space>fs"
  }
  
  for _, keymap in ipairs(keymaps_to_test) do
    local ok, _ = pcall(vim.keymap.get, "n", keymap)
    if ok then
      print("✅ " .. keymap .. " is registered")
    else
      print("❌ " .. keymap .. " is NOT registered")
    end
  end
end

local function test_dependencies()
  print("\n🔧 Testing dependencies...")
  
  local deps = {
    { name = "ripgrep", cmd = "rg" },
    { name = "fd", cmd = "fd" }
  }
  
  for _, dep in ipairs(deps) do
    local ok = vim.fn.executable(dep.cmd) == 1
    if ok then
      print("✅ " .. dep.name .. " (" .. dep.cmd .. ") is available")
    else
      print("❌ " .. dep.name .. " (" .. dep.cmd .. ") is NOT available")
    end
  end
end

-- Run tests
local success = test_telescope()
test_keymaps()
test_dependencies()

if success then
  print("\n🎉 Telescope configuration test passed!")
  print("\n📝 Next steps:")
  print("1. Press <space>ff to find files")
  print("2. Press <space>fg to live grep")
  print("3. Press <space>fb to browse buffers")
  print("4. Check :Telescope extensions for available extensions")
else
  print("\n💥 Telescope configuration test failed!")
  print("\n🔧 Troubleshooting:")
  print("1. Check :checkhealth telescope")
  print("2. Install dependencies: sudo pacman -S ripgrep fd")
  print("3. Run :Lazy sync to update plugins")
  print("4. Restart Neovim and try again")
end 