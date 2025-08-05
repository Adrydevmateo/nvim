-- Test script for Telescope in React/Vite projects
-- Run this in Neovim with: :lua dofile("tests/test_react_telescope.lua")

local function test_telescope_basic()
  print("🔍 Testing Telescope basic functionality...")
  
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
  return true
end

local function test_react_vite_files()
  print("\n⚛️ Testing React/Vite file detection...")
  
  -- Check for common React/Vite files
  local react_files = {
    "package.json",
    "vite.config.js",
    "vite.config.ts",
    "tsconfig.json",
    "jsconfig.json",
    "src/main.jsx",
    "src/main.tsx",
    "src/App.jsx",
    "src/App.tsx",
    "index.html",
  }
  
  local found_files = 0
  for _, file in ipairs(react_files) do
    local exists = vim.fn.filereadable(file) == 1
    if exists then
      print("✅ Found: " .. file)
      found_files = found_files + 1
    else
      print("❌ Missing: " .. file)
    end
  end
  
  if found_files > 0 then
    print("✅ React/Vite project detected (" .. found_files .. " files found)")
  else
    print("⚠️ No React/Vite files found - are you in the right directory?")
  end
  
  return found_files > 0
end

local function test_dependencies()
  print("\n🔧 Testing dependencies...")
  
  local deps = {
    { name = "ripgrep", cmd = "rg" },
    { name = "fd", cmd = "fd" }
  }
  
  local all_available = true
  for _, dep in ipairs(deps) do
    local ok = vim.fn.executable(dep.cmd) == 1
    if ok then
      print("✅ " .. dep.name .. " (" .. dep.cmd .. ") is available")
    else
      print("❌ " .. dep.name .. " (" .. dep.cmd .. ") is NOT available")
      all_available = false
    end
  end
  
  return all_available
end

local function test_telescope_commands()
  print("\n⌨️ Testing Telescope commands...")
  
  local commands = {
    "<space>ff",
    "<space>fg", 
    "<space>fb",
    "<space>fh",
    "<space>fo",
    "<space>fc",
    "<space>fs"
  }
  
  local working_commands = 0
  for _, cmd in ipairs(commands) do
    local ok, _ = pcall(vim.keymap.get, "n", cmd)
    if ok then
      print("✅ " .. cmd .. " is registered")
      working_commands = working_commands + 1
    else
      print("❌ " .. cmd .. " is NOT registered")
    end
  end
  
  -- Test Telescope user commands
  print("\n🔧 Testing Telescope user commands...")
  local telescope_cmd = vim.api.nvim_get_commands({})["Telescope"]
  if telescope_cmd then
    print("✅ :Telescope command is available")
    working_commands = working_commands + 1
  else
    print("❌ :Telescope command is NOT available")
  end
  
  return working_commands == #commands + 1
end

local function test_file_search()
  print("\n📁 Testing file search functionality...")
  
  -- Test if we can find files in the current directory
  local ok, _ = pcall(function()
    local builtin = require("telescope.builtin")
    -- This will just test if the function exists, not actually run it
    if builtin.find_files then
      print("✅ find_files function available")
      return true
    else
      print("❌ find_files function not available")
      return false
    end
  end)
  
  if not ok then
    print("❌ Error testing find_files")
    return false
  end
  
  return true
end

local function suggest_solutions()
  print("\n🔧 Solutions for React/Vite projects:")
  print("1. Install dependencies:")
  print("   sudo pacman -S ripgrep fd")
  print("2. Make sure you're in the project root directory")
  print("3. Check if package.json exists")
  print("4. Try running Telescope commands manually:")
  print("   :Telescope find_files")
  print("   :Telescope live_grep")
  print("5. Check for .gitignore patterns that might be blocking files")
  print("6. Restart Neovim and try again")
end

-- Run all tests
local basic_ok = test_telescope_basic()
local react_ok = test_react_vite_files()
local deps_ok = test_dependencies()
local commands_ok = test_telescope_commands()
local search_ok = test_file_search()

print("\n" .. string.rep("=", 50))
print("📊 Test Results:")
print("Basic Telescope: " .. (basic_ok and "✅" or "❌"))
print("React/Vite files: " .. (react_ok and "✅" or "❌"))
print("Dependencies: " .. (deps_ok and "✅" or "❌"))
print("Commands: " .. (commands_ok and "✅" or "❌"))
print("File search: " .. (search_ok and "✅" or "❌"))

if basic_ok and deps_ok and commands_ok and search_ok then
  print("\n🎉 Telescope should work in your React/Vite project!")
  print("\n📝 Try these commands:")
  print("1. <space>ff - Find files")
  print("2. <space>fg - Live grep")
  print("3. <space>fb - Browse buffers")
  print("4. :Telescope find_files - Manual file search")
else
  print("\n💥 Some tests failed!")
  suggest_solutions()
end 