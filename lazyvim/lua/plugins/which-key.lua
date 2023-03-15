return {
  -- Modify which-key keys
  {
    "folke/which-key.nvim",
    opts = function()
      require("which-key").register({
        ["<leader>p"] = {
          name = "+project",
        },
        ["<leader>d"] = {
          name = "+debug",
        },
      })
    end,
    keys = {
      {
        "<leader>cx",
        "<cmd>TroubleToggle<cr>",
        desc = "Diagnostics",
      },
      {
        "<leader>sp",
        "<cmd>Telescope live_grep<cr>",
        desc = "Search project",
      },
      {
        "<leader>si",
        "<cmd>Telescope lsp_document_symbols<cr>",
        desc = "Jump to symbol",
      },
    },
  },
}
