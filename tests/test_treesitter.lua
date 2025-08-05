-- Test script for Treesitter configuration
-- Run this in Neovim with: :lua dofile("tests/test_treesitter.lua")

local function test_treesitter()
  print("🌳 Testing Treesitter configuration...")
  
  -- Test if treesitter can be loaded
  local ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not ok then
    print("❌ Failed to load nvim-treesitter")
    return false
  end
  
  print("✅ Treesitter loaded successfully")
  
  -- Test if parsers can be installed
  local utils = require("core.utils")
  if not utils or not utils.treesitter_languages then
    print("❌ Treesitter languages not configured")
    return false
  end
  
  print("✅ Treesitter languages configured")
  
  -- Check for invalid parsers
  local invalid_parsers = {
    "jsx",  -- Handled by javascript parser
    "tsx",  -- Handled by typescript parser
    "gitrebase", -- Not available
  }
  
  local found_invalid = false
  for _, parser in ipairs(invalid_parsers) do
    for _, configured_parser in ipairs(utils.treesitter_languages) do
      if parser == configured_parser then
        print("❌ Invalid parser found: " .. parser)
        found_invalid = true
      end
    end
  end
  
  if not found_invalid then
    print("✅ No invalid parsers found")
  end
  
  -- Test specific parsers
  local test_parsers = {
    "javascript", -- Should handle JSX
    "typescript", -- Should handle TSX
    "lua",
    "json",
  }
  
  for _, parser in ipairs(test_parsers) do
    local parser_ok = false
    for _, configured_parser in ipairs(utils.treesitter_languages) do
      if parser == configured_parser then
        parser_ok = true
        break
      end
    end
    
    if parser_ok then
      print("✅ Parser configured: " .. parser)
    else
      print("❌ Parser missing: " .. parser)
    end
  end
  
  return not found_invalid
end

local function test_jsx_tsx_support()
  print("\n⚛️ Testing JSX/TSX support...")
  
  -- Test if we can detect JSX/TSX file types
  local file_types = {
    { ext = ".jsx", type = "javascript" },
    { ext = ".tsx", type = "typescript" },
    { ext = ".js", type = "javascript" },
    { ext = ".ts", type = "typescript" },
  }
  
  for _, file_info in ipairs(file_types) do
    local ft = vim.filetype.match({ filename = "test" .. file_info.ext })
    if ft == file_info.type then
      print("✅ " .. file_info.ext .. " -> " .. file_info.type)
    else
      print("❌ " .. file_info.ext .. " -> " .. (ft or "unknown"))
    end
  end
end

local function suggest_installation()
  print("\n📦 To install Treesitter parsers:")
  print("1. Run :TSInstall javascript")
  print("2. Run :TSInstall typescript")
  print("3. Run :TSInstall lua")
  print("4. Or run :TSInstall all to install all configured parsers")
  print("5. Run :TSUpdate to update existing parsers")
end

-- Run tests
local success = test_treesitter()
test_jsx_tsx_support()

if success then
  print("\n🎉 Treesitter configuration is correct!")
  print("\n📝 Next steps:")
  print("1. Run :TSInstall all to install parsers")
  print("2. Test syntax highlighting in JSX/TSX files")
  print("3. Check :TSBufInfo for current buffer info")
else
  print("\n💥 Treesitter configuration has issues!")
  suggest_installation()
end 