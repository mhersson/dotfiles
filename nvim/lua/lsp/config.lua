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
    "sumneko_lua",
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
  lspconfig.sumneko_lua.setup({
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace"
        }
      }
    }
  })
else
  lspconfig.sumneko_lua.setup(vim.tbl_deep_extend("force", require("lsp.settings.sumneko_lua"), defaults))
end

lspconfig.gopls.setup(vim.tbl_deep_extend("force", require("lsp.settings.gopls"), defaults))
lspconfig.rust_analyzer.setup(defaults) -- rust-analyzer is configured with the plugin in plugins/config/rust-tools
lspconfig.bashls.setup(defaults)
lspconfig.dockerls.setup(defaults)
lspconfig.jsonls.setup(defaults)
lspconfig.pyright.setup(defaults)
lspconfig.yamlls.setup(defaults)
