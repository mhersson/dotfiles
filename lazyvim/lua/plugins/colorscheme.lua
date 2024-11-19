return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin-mocha",
      colorscheme = "tokyonight",
      -- colorscheme = "solarized",
    },
  },
  -- {
  --   "maxmx03/solarized.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.o.background = "light" -- or 'dark'
  --   end,
  -- },
}
