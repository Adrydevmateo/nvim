local M = {}

-- Check if a plugin is installed
function M.has(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

-- Check if a command exists
function M.has_command(command)
  return vim.fn.executable(command) == 1
end

-- Get the operating system
function M.get_os()
  return vim.loop.os_uname().sysname
end

-- Check if running in WSL
function M.is_wsl()
  local output = vim.fn.systemlist("uname -r")
  return not not string.find(output[1] or "", "WSL")
end

-- Check if running in Docker
function M.is_docker()
  local file = io.open("/proc/1/cgroup", "r")
  if file then
    local content = file:read("*all")
    file:close()
    return string.find(content, "docker") ~= nil
  end
  return false
end

return M 