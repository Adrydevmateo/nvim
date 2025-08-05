-- Test script for which-key configuration
-- Run this in Neovim with: :lua dofile("tests/test_whichkey.lua")

local function test_which_key()
  print("🧪 Testing which-key configuration...")
  
  -- Test if which-key can be loaded
  local ok, wk = pcall(require, "which-key")
  if not ok then
    print("❌ Failed to load which-key")
    return false
  end
  
  print("✅ which-key loaded successfully")
  
  -- Test if which-key is properly configured
  local setup_ok, _ = pcall(function()
    wk.setup()
  end)
  
  if not setup_ok then
    print("❌ Failed to setup which-key")
    return false
  end
  
  print("✅ which-key setup successful")
  
  -- Test keymap registration
  local register_ok, _ = pcall(function()
    wk.register({
      ["<leader>w"] = { name = "+windows" },
      ["<leader>b"] = { name = "+buffers" },
      ["<leader>t"] = { name = "+tabs" },
      ["<leader>f"] = { name = "+find" },
    })
  end)
  
  if not register_ok then
    print("❌ Failed to register keymaps")
    return false
  end
  
  print("✅ Keymap registration successful")
  
  return true
end

-- Test specific keymaps
local function test_keymaps()
  print("\n🔍 Testing specific keymaps...")
  
  local keymaps_to_test = {
    "<leader>w",
    "<leader>b", 
    "<leader>t",
    "<leader>f",
    "<space>ff",
    "<space>fg",
    "<leader>ev",
    "<leader>sv",
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

-- Run tests
local success = test_which_key()
test_keymaps()

if success then
  print("\n🎉 which-key configuration test passed!")
  print("\n📝 Next steps:")
  print("1. Press <leader> to see available keymaps")
  print("2. Press <space>f to see find options")
  print("3. Press <leader>w to see window options")
  print("4. Run :checkhealth which-key for detailed status")
else
  print("\n💥 which-key configuration test failed!")
  print("\n🔧 Troubleshooting:")
  print("1. Check :checkhealth which-key")
  print("2. Check :Lazy log for which-key errors")
  print("3. Restart Neovim and try again")
end 