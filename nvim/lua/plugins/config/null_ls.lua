local plugin_loaded, null_ls = pcall(require, "null-ls")
if not plugin_loaded then return end

-- formatting sources
local formatting = null_ls.builtins.formatting

local sources = {
  formatting.shfmt.with({
    extra_args = { "-i", "2", "-ci" },
  }),
  formatting.prettier.with({
    filetypes = { "html", "json", "yaml", "markdown" },
  }),
  formatting.nixfmt.with({
    filetypes = { "nix" },
  }),
  formatting.black.with({
    filetypes = { "python" },
  })
}

null_ls.setup({ sources = sources })
