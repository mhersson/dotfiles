return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        sh = { "shellcheck" },
        go = { "golangcilint" },
        py = { "pylint" },
      },
      ---@type table<string,table>
      linters = {},
    },
  },
}
