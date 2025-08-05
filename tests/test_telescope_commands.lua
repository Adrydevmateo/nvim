-- Test script for Telescope commands
-- Run this in Neovim with: :lua dofile("tests/test_telescope_commands.lua")

local function test_telescope_loading()
  print("🔍 Testing Telescope loading...")
  
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

local function test_telescope_commands()
  print("\n⌨️ Testing Telescope commands...")
  
  -- Test user commands
  local commands = {
    "Telescope",
  }
  
  for _, cmd in ipairs(commands) do
    local cmd_info = vim.api.nvim_get_commands({})[cmd]
    if cmd_info then
      print("✅ :" .. cmd .. " command is available")
    else
      print("❌ :" .. cmd .. " command is NOT available")
    end
  end
  
  -- Test keymaps
  local keymaps = {
    "<space>ff",
    "<space>fg", 
    "<space>fb",
    "<space>fh",
    "<space>fo",
    "<space>fc",
    "<space>fs"
  }
  
  for _, keymap in ipairs(keymaps) do
    local ok, _ = pcall(vim.keymap.get, "n", keymap)
    if ok then
      print("✅ " .. keymap .. " keymap is registered")
    else
      print("❌ " .. keymap .. " keymap is NOT registered")
    end
  end
end

local function test_telescope_functions()
  print("\n🔧 Testing Telescope functions...")
  
  local ok, builtin = pcall(require, "telescope.builtin")
  if not ok then
    print("❌ Cannot load telescope.builtin")
    return false
  end
  
  local functions = {
    "find_files",
    "live_grep",
    "buffers",
    "help_tags",
    "oldfiles",
    "git_commits",
    "git_status"
  }
  
  local available_functions = 0
  for _, func in ipairs(functions) do
    if builtin[func] then
      print("✅ " .. func .. " function is available")
      available_functions = available_functions + 1
    else
      print("❌ " .. func .. " function is NOT available")
    end
  end
  
  return available_functions == #functions
end

local function suggest_usage()
  print("\n📝 How to use Telescope:")
  print("1. Keymaps:")
  print("   <space>ff - Find files")
  print("   <space>fg - Live grep")
  print("   <space>fb - Browse buffers")
  print("   <space>fh - Help tags")
  print("   <space>fo - Old files")
  print("   <space>fc - Git commits")
  print("   <space>fs - Git status")
  print("")
  print("2. Commands:")
  print("   :Telescope find_files")
  print("   :Telescope live_grep")
  print("   :Telescope buffers")
  print("   :Telescope help_tags")
  print("   :Telescope oldfiles")
  print("   :Telescope git_commits")
  print("   :Telescope git_status")
end

-- Run tests
local loading_ok = test_telescope_loading()
test_telescope_commands()
local functions_ok = test_telescope_functions()

if loading_ok and functions_ok then
  print("\n🎉 Telescope commands are working!")
  suggest_usage()
else
  print("\n💥 Telescope has issues!")
  print("\n🔧 Troubleshooting:")
  print("1. Restart Neovim")
  print("2. Check :Lazy log for Telescope errors")
  print("3. Run :Lazy sync to update plugins")
  print("4. Check if dependencies (ripgrep, fd) are installed")
end 