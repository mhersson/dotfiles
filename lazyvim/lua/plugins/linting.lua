return {
  -- change null-ls config
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      local formatting = nls.builtins.formatting
      opts.sources = {
        formatting.shfmt.with({
          extra_args = { "-i", "2", "-ci", "-bn" },
        }),
        formatting.prettier.with({
          filetypes = { "html", "json", "markdown" },
        }),
        formatting.yamlfmt.with({
          filetypes = { "yaml" },
        }),
        formatting.nixfmt.with({
          filetypes = { "nix" },
        }),
        formatting.black.with({
          filetypes = { "python" },
        }),
      }

      opts.sources = vim.list_extend(opts.sources, { nls.builtins.diagnostics.golangci_lint })
      -- opts.sources = vim.list_extend(opts.sources, { nls.builtins.diagnostics.shellcheck })
    end,
  },
}
