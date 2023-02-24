return {
  -- change null-ls config
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, { nls.builtins.diagnostics.golangci_lint })
      -- opts.sources = vim.list_extend(opts.sources, { nls.builtins.diagnostics.shellcheck })
    end,
  },
}
