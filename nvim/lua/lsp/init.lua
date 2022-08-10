local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then return end

require("lsp.config")
require("lsp.linting")
require("lsp.formatting")
require("lsp.handlers").setup()
