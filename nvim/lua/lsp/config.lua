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
    "sumneko_lua",
    "yamlls",
  }
}

local defaults = {
  on_attach = require("lsp.handlers").on_attach,
  capabilities = require("lsp.handlers").capabilities,
}

local lspconfig = require("lspconfig")

local luadev_ok, luadev = pcall(require, "lua-dev")
if luadev_ok then
  lspconfig.sumneko_lua.setup(luadev.setup(vim.tbl_deep_extend("force", require("lsp.settings.sumneko_lua"), defaults)))
else
  lspconfig.sumneko_lua.setup(vim.tbl_deep_extend("force", require("lsp.settings.sumneko_lua"), defaults))
end

lspconfig.bashls.setup(defaults)
lspconfig.gopls.setup(defaults)
lspconfig.dockerls.setup(defaults)
lspconfig.jsonls.setup(defaults)
lspconfig.yamlls.setup(defaults)
