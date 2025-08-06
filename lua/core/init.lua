-- Core configuration initialization
-- Loads all core modules in the correct order

local performance = require("core.performance")
local options = require("core.options")
local ui = require("core.ui")
local keymaps = require("core.keymaps")
local autocmds = require("core.autocmds")

local M = {}

function M.setup()
  -- Load core modules in order
  performance.setup()
  options.setup()
  ui.setup()
  keymaps.setup()
  autocmds.setup()
end

return M
