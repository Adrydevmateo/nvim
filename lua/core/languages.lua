local M = {}

M.servers = {
  "lua_ls",
  "cssls",
  "html",
  "jsonls",
  "tailwindcss",
  "eslint",
  "bashls",
  "yamlls",
	"pyright",
}

M.parsers = {
  "lua",
  "markdown",
  "javascript",
  "typescript",
  "tsx",
  "html",
  "css",
  "json",
  "yaml",
	"python",
}

M.fmtNLint = {
  "prettier",
  "stylua",
}

return M
