-- UI configuration and colorscheme
-- Handles colors, highlighting, and statusline

local M = {}

function M.setup()
  -- Performance-focused colorscheme
  vim.cmd([[
    colorscheme default
    highlight Normal ctermbg=NONE guibg=NONE
    highlight LineNr ctermfg=gray guifg=gray
    highlight CursorLine ctermbg=black guibg=#1a1a1a
    highlight CursorColumn ctermbg=black guibg=#1a1a1a
    highlight Search ctermbg=yellow ctermfg=black guibg=yellow guifg=black
    highlight IncSearch ctermbg=red ctermfg=white guibg=red guifg=white
    highlight Visual ctermbg=blue guibg=#3a3a3a
    highlight Pmenu ctermbg=black ctermfg=white guibg=#2a2a2a guifg=white
    highlight PmenuSel ctermbg=blue ctermfg=white guibg=#4a4a4a guifg=white
  ]])

  -- Custom statusline for better performance
  vim.opt.statusline = "%<%f %h%m%r%=%-14.(%l,%c%V%) %P"
end

return M
