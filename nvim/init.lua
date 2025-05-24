-- Load core configuration
require("config")

-- Bootstrap lazy.nvim
require("config.lazy")

vim.lsp.enable({
    "bashls",
    "golangci_lint_ls",
    "gopls",
    "lua_ls",
    "marksman",
    "mpls",
    "regal",
    "yamlls",
})
