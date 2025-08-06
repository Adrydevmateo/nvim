-- UI configuration and colorscheme
-- Handles colors, highlighting, and statusline

local M = {}

function M.setup()
  -- Custom statusline for better performance
  vim.opt.statusline = "%<%f %h%m%r%=%-14.(%l,%c%V%) %P"
  
  -- Note: Colorscheme is now handled by Kanagawa plugin
  -- The plugin will be loaded after core modules and will set the colorscheme
end

return M
