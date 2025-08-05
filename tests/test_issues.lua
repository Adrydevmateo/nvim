-- Comprehensive test script for which-key and fidget issues
-- Run this in Neovim with: :lua dofile("tests/test_issues.lua")

local function test_which_key()
  print("🔍 Testing which-key configuration...")
  
  -- Test if which-key can be loaded
  local ok, wk = pcall(require, "which-key")
  if not ok then
    print("❌ Failed to load which-key")
    return false
  end
  
  print("✅ which-key loaded successfully")
  
  -- Test for conflicting keymaps
  local conflicts = {}
  local keymaps = {
    "<leader>tn", -- Tab new vs Toggle number
    "<leader>tl", -- Tab last vs Toggle list
  }
  
  for _, keymap in ipairs(keymaps) do
    local mappings = vim.keymap.get("n", keymap)
    if mappings then
      table.insert(conflicts, keymap)
    end
  end
  
  if #conflicts > 0 then
    print("⚠️ Potential keymap conflicts found:")
    for _, conflict in ipairs(conflicts) do
      print("   - " .. conflict)
    end
  else
    print("✅ No keymap conflicts detected")
  end
  
  return true
end

local function test_fidget()
  print("\n🔧 Testing fidget.nvim configuration...")
  
  -- Test if fidget can be loaded
  local ok, fidget = pcall(require, "fidget")
  if not ok then
    print("❌ Failed to load fidget")
    return false
  end
  
  print("✅ fidget loaded successfully")
  
  -- Test fidget setup
  local setup_ok, _ = pcall(function()
    fidget.setup({
      notification = {
        window = {
          winblend = 0,
        },
      },
    })
  end)
  
  if not setup_ok then
    print("❌ Failed to setup fidget")
    return false
  end
  
  print("✅ fidget setup successful")
  return true
end

local function check_health()
  print("\n🏥 Running health checks...")
  
  -- Check which-key health
  local wk_health = vim.fn.system("nvim --headless --noplugin -c 'lua require(\"which-key\").setup()' -c 'quit' 2>&1")
  if wk_health:match("error") then
    print("❌ which-key health check failed")
    print("   " .. wk_health)
  else
    print("✅ which-key health check passed")
  end
  
  -- Check for unknown options
  local fidget_health = vim.fn.system("nvim --headless --noplugin -c 'lua require(\"fidget\").setup()' -c 'quit' 2>&1")
  if fidget_health:match("unknown") then
    print("❌ fidget health check failed")
    print("   " .. fidget_health)
  else
    print("✅ fidget health check passed")
  end
end

local function suggest_fixes()
  print("\n🔧 Suggested fixes:")
  print("1. Restart Neovim to apply configuration changes")
  print("2. Run :checkhealth which-key for detailed which-key status")
  print("3. Run :checkhealth fidget for detailed fidget status")
  print("4. Check :Lazy log for plugin loading issues")
  print("5. If issues persist, run :Lazy clean and restart")
end

-- Run all tests
local wk_success = test_which_key()
local fidget_success = test_fidget()
check_health()

if wk_success and fidget_success then
  print("\n🎉 All tests passed!")
  print("\n📝 Next steps:")
  print("1. Press <leader> to see available keymaps")
  print("2. Test LSP functionality in a supported file")
  print("3. Check that fidget shows LSP status")
else
  print("\n💥 Some tests failed!")
  suggest_fixes()
end 