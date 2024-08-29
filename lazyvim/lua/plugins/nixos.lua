-- Custom settings just for NixOS - comment out this file in not on NixOS
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = {}
    end,
  },
  {
    "mfussenger/nvim-dap-python",
    enabled = false,
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
