return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        sh = { "shfmt" },
        yaml = { "yamlfmt" },
      },

      formatters = {
        shfmt = {
          args = { "-i", "2", "-ci", "-bn" },
        },
      },
    },
  },
}
