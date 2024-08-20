-- Custom settings just for NixOS - comment out this file in not on NixOS
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      for i, v in ipairs(opts.ensure_installed) do
        --  if v == "marksman" then
        table.remove(opts.ensure_installed, i)
        --    break
        --  end
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = { mason = false },
        lua_ls = { mason = false },
        jsonls = { mason = false },
        marksman = { mason = false },
        nil_ls = { mason = false },
        pyright = { mason = false },
        ruff = { mason = false },
        rust_analyzer = { mason = false },
        yamlls = { mason = false },
      },
    },
  },
}
