return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        yamlls = {
          settings = {
            yaml = {
              -- disable formatting because it's handled by yamlfmt
              format = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
}
