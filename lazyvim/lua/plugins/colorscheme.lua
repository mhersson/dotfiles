return {
  -- add catppuccin
  -- {
  --   "catppuccin/nvim",
  --   opts = {
  --     flavour = "macchiato", -- latte, frappe, macchiato, mocha
  --   },
  --   config = function(_, opts)
  --     require("catppuccin").setup(opts)
  --   end,
  -- },
  --
  -- {
  --   "olimorris/onedarkpro.nvim",
  --   config = function()
  --     require("onedarkpro").setup({
  --       colors = {
  --         bg = "#24273a",
  --         fg = "#cad3f5",
  --       },
  --     })
  --   end,
  -- },
  --
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     transparent = true,
  --   },
  --   config = function(_, opts)
  --     require("tokyonight").setup(opts)
  --   end,
  -- },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-storm",
    },
  },


}
