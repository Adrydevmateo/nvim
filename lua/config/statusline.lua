-- 1. Function to safely pull colors from the current active theme
local function get_hl_color(group, attribute)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  return hl[attribute]
end

-- 2. Function to rebuild statusline colors based on current theme variables
local function setup_statusline_colors()
  -- Pull vibrant syntax token foregrounds to use as our solid backgrounds
  local green  = get_hl_color('String', 'fg')      or get_hl_color('DiagnosticOk', 'fg') or '#a3be8c'
  local blue   = get_hl_color('Function', 'fg')    or get_hl_color('DiagnosticInfo', 'fg') or '#81a1c1'
  local purple = get_hl_color('Keyword', 'fg')     or get_hl_color('DiagnosticHint', 'fg') or '#b48ead'
  local yellow = get_hl_color('Number', 'fg')      or get_hl_color('DiagnosticWarn', 'fg') or '#ebcb8b'
  
  -- Force text inside the bright blocks to match your main editor canvas background
  local text_dark = get_hl_color('Normal', 'bg') or '#1e1e1e'
  
  -- Structural center elements
  local path_bg = get_hl_color('StatusLine', 'bg')   or '#2e3440'
  local path_fg = get_hl_color('StatusLine', 'fg')   or '#d8dee9'
  local type_bg = get_hl_color('StatusLineNC', 'bg') or '#3b4252'
  
  -- FIX: Pull fg from 'StatusLine' instead of 'StatusLineNC' to make it bright
  local type_fg = get_hl_color('StatusLine', 'fg')   or '#d8dee9'

  -- Apply high-contrast inversions to the layout highlights
  vim.api.nvim_set_hl(0, 'StatusNormal', { bg = green,  fg = text_dark, bold = true })
  vim.api.nvim_set_hl(0, 'StatusInsert', { bg = blue,   fg = text_dark, bold = true })
  vim.api.nvim_set_hl(0, 'StatusVisual', { bg = purple, fg = text_dark, bold = true })
  
  vim.api.nvim_set_hl(0, 'StatusPath',   { bg = path_bg, fg = path_fg })
  vim.api.nvim_set_hl(0, 'StatusWin',    { bg = yellow,  fg = text_dark, bold = true })
  vim.api.nvim_set_hl(0, 'StatusType',   { bg = type_bg, fg = type_fg })
end

-- 3. Run the colorscheme watcher
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = setup_statusline_colors,
})

-- Initialize the colors right away on startup
setup_statusline_colors()

-- 4. Main Statusline engine 
local mode_data = {
  ['n']     = { text = ' NORMAL ', hl = 'StatusNormal' },
  ['v']     = { text = ' VISUAL ', hl = 'StatusVisual' },
  ['V']     = { text = ' V-LINE ', hl = 'StatusVisual' },
  ['\22']   = { text = ' V-BLOCK ', hl = 'StatusVisual' },
  ['i']     = { text = ' INSERT ', hl = 'StatusInsert' },
  ['R']     = { text = ' REPLACE ', hl = 'StatusInsert' },
  ['c']     = { text = ' COMMAND ', hl = 'StatusNormal' },
}

function _G.custom_statusline()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_info = mode_data[current_mode] or { text = ' NORMAL ', hl = 'StatusNormal' }

  local mode_section = '%#' .. mode_info.hl .. '#' .. mode_info.text
  local path_section = '%#StatusPath# %f %m %r '
  local separator = '%='
  local win_section = '%#StatusWin# W:%{winnr()} '
  local type_section = '%#StatusType# %y '

  local current_line = vim.fn.line('.')
  local total_lines = vim.fn.line('$')
  local current_col  = vim.fn.col('.')
  local total_chars = vim.fn.col('$') - 1
  local pct = math.floor((current_line / total_lines) * 100)

  local pos_str = string.format(' %d/%d · %d/%d %d%% ', current_line, total_lines, current_col, total_chars, pct)
  local pos_section = '%#' .. mode_info.hl .. '#' .. pos_str

  return table.concat({ mode_section, path_section, separator, win_section, type_section, pos_section })
end

vim.opt.statusline = '%{%v:lua.custom_statusline()%}'
vim.opt.laststatus = 3

