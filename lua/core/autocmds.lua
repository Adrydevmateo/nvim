-- Autocommands and file type specific settings
-- Handles automatic commands and file type configurations

local M = {}

function M.setup()
  -- File type specific settings
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.linebreak = true
      vim.opt_local.textwidth = 80
    end
  })

  -- Auto-create undo directory
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      local undo_dir = vim.fn.stdpath("data") .. "/undo"
      if vim.fn.isdirectory(undo_dir) == 0 then
        vim.fn.mkdir(undo_dir, "p")
      end
    end
  })

  -- Performance monitoring (optional - comment out if not needed)
  -- vim.api.nvim_create_autocmd("VimEnter", {
  --   callback = function()
  --     vim.cmd("profile start profile.log")
  --     vim.cmd("profile func *")
  --     vim.cmd("profile file *")
  --   end
  -- })
end

return M
