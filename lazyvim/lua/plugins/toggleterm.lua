return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-`>]],
      direction = "horizontal",
      float_opts = {
        border = "curved",
      },
      highlights = {
        FloatBorder = {
          guifg = "#8AADF4",
        },
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
    end,
  },
}
