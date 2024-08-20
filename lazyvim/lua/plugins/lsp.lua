return {
  {
    "neovim/nvim-lspconfig",
    codelens = {
      enabled = true,
    },
    opts = {
      inlay_hints = {
        enabled = true,
        exclude = { "go", "cue" },
      },
      document_highlight = {
        enabled = false,
        fileMatch = { "cue" },
      },
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
