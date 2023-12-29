return {
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "catppuccin-macchiato",
  --   },
  -- },
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "light" -- or 'dark'

      vim.cmd.colorscheme("solarized")
    end,
  },
}
