-- Set up autocommands for automating repetitive tasks or triggering actions based on events.

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
vim.api.nvim_create_user_command('LoadNeotree', function()
	require('neo-tree').setup({})
end, {})

-- [ Organize imports and format code | Go | Golang ]
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*.go',
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { 'source.organizeImports' } }
		local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)

		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end

		vim.lsp.buf.format({ async = false })
	end,
})
