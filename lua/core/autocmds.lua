-- Set up autocommands for automating repetitive tasks or triggering actions based on events.

-- [ Define the Treesitter setup command | TreesitterSetup ]
vim.api.nvim_create_user_command('TreesitterSetup', function() 
	require'nvim-treesitter.configs'.setup {}
end, {})

-- [ Define a command to close all buffers and exit Neovim ]
vim.api.nvim_create_user_command('QuitAll', function()
  -- Close all buffers
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) and buf ~= vim.api.nvim_get_current_buf() then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
  -- Exit Neovim
  vim.cmd('quit')
end, {})

-- [ Define a command to activate Neotree ]
vim.api.nvim_create_user_command('NeotreeActivation', function() 
	require'neo-tree'.setup {}
end, {})

-- [ Define a command to load Mason ]
vim.api.nvim_create_user_command('LoadMason', load_mason, {})
vim.api.nvim_create_user_command('LoadLSPConfig', load_lspconfig, {})

-- [ Define a command to load LSPConfig ]
