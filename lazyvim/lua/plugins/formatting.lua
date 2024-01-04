return {
  {
    "nvimtools/none-ls.nvim",
    enabled = false,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cue = { "cue" },
        sh = { "shfmt" },
        yaml = { "yamlfmt" },
        go = { "gofumpt", "goimports" },
      },

      formatters = {
        shfmt = {
          args = { "-i", "2", "-ci", "-bn" },
        },
      },
    },
  },
}
