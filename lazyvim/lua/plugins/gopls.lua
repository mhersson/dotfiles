return {
  -- add gopls to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- gopls will be automatically installed with mason and loaded with lspconfig
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              usePlaceholders = true,
              completeUnimported = true,
              deepCompletion = true,
              semanticTokens = true,
            },
          },
        },
      },
    },
  },
}
