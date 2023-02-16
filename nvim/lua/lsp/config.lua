local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

lsp_installer.setup {
  ensure_installed = {
    "bashls",
    "gopls",
    "dockerls",
    "jsonls",
    "pyright",
    "lua_ls",
    "yamlls",
  }
}

local defaults = {
  on_attach = require("lsp.handlers").on_attach,
  capabilities = require("lsp.handlers").capabilities,
}

local lspconfig = require("lspconfig")

local neodev_ok, neodev = pcall(require, "neodev")
if neodev_ok then
  neodev.setup({})
end

lspconfig.gopls.setup(vim.tbl_deep_extend("force", require("lsp.settings.gopls"), defaults))
lspconfig.rust_analyzer.setup(defaults) -- rust-analyzer is configured with the plugin in plugins/config/rust-tools
lspconfig.bashls.setup(defaults)
lspconfig.dockerls.setup(defaults)
lspconfig.jsonls.setup(defaults)
lspconfig.lua_ls.setup(defaults)
lspconfig.pyright.setup(defaults)
lspconfig.yamlls.setup(defaults)
