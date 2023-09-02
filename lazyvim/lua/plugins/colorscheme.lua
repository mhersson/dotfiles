return {
  {
    "catppuccin/nvim",
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
    end,
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     style = "storm",
  --   },
  -- },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
