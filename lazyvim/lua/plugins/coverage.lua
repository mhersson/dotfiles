return {
  {
    "andythigpen/nvim-coverage",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      lang = {
        go = {
          coverage_file = "cover.out",
        },
      },
    },
    config = true,
    keys = {
      {
        "<leader>tcc",
        function()
          require("coverage").load(true)
        end,
        desc = "Coverage",
      },
      {
        "<leader>tcl",
        function()
          require("coverage").clear()
        end,
        desc = "Clear Coverage",
      },
      {
        "<leader>tct",
        function()
          require("coverage").toggle()
        end,
        desc = "Toggle Coverage",
      },
      {
        "<leader>tcs",
        function()
          require("coverage").summary()
        end,
        desc = "Coverage Summary",
      },
    },
  },
}
