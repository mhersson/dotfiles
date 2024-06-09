return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },
    keys = {
      {
        "<leader>gg",
        "<cmd>Neogit<cr>",
        desc = "Neogit",
      },
    },
    opts = {
      -- Do not ask to confirm the commit - just do it when the buffer is closed.
      disable_commit_confirmation = true,
      sections = {
        recent = {
          folded = false,
        },
      },
    },
  },
}
