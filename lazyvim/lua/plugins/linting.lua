return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        sh = { "shellcheck" },
        go = { "golangcilint" },
        markdown = { "markdownlint-cli2" },
        py = { "pylint" },
        cue = { "cue" },
      },
      ---@type table<string,table>
      linters = {},
    },
  },
}
