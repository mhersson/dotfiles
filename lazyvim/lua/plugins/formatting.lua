return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- cue = { "cue_fmt" },
        sh = { "shfmt" },
        yaml = { "yamlfmt" },
        go = { "gofumpt" },
      },

      formatters = {
        shfmt = {
          args = { "-i", "2", "-ci", "-bn" },
        },
      },
    },
  },
}
