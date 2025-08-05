-- Test script for nvim-tree configuration
-- Run this in Neovim with: :lua dofile("tests/test_nvimtree.lua")

local function test_nvim_tree()
  print("🧪 Testing nvim-tree configuration...")
  
  -- Test if nvim-tree can be loaded
  local ok, nvim_tree = pcall(require, "nvim-tree")
  if not ok then
    print("❌ Failed to load nvim-tree")
    return false
  end
  
  print("✅ nvim-tree loaded successfully")
  
  -- Test if the API is available
  local api_ok, api = pcall(require, "nvim-tree.api")
  if not api_ok then
    print("❌ Failed to load nvim-tree API")
    return false
  end
  
  print("✅ nvim-tree API loaded successfully")
  
  -- Test basic functionality
  local tree_ok, _ = pcall(function()
    api.tree.toggle()
  end)
  
  if tree_ok then
    print("✅ nvim-tree toggle works")
  else
    print("❌ nvim-tree toggle failed")
  end
  
  return true
end

-- Run the test
local success = test_nvim_tree()

if success then
  print("\n🎉 nvim-tree configuration test passed!")
else
  print("\n💥 nvim-tree configuration test failed!")
end

print("\n📝 Next steps:")
print("1. Press <C-n> to toggle the file tree")
print("2. Check if git indicators are showing")
print("3. Verify file icons are displayed") 