return {
  -- Modify which-key keys
  {
    "folke/which-key.nvim",
    opts = function()
      require("which-key").register({
        ["<leader>tc"] = {
          name = "+coverage",
        },
      })
    end,
    keys = {
      {
        "<leader>gb",
        "<cmd>Gitsigns blame_line<cr>",
        desc = "Blame line",
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
