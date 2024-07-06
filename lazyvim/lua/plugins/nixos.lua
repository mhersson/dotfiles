-- Custom settings just for NixOS - comment out this file in not on NixOS
return {
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     for i, v in ipairs(opts.ensure_installed) do
  --       if v == "marksman" then
  --         table.remove(opts.ensure_installed, i)
  --         break
  --       end
  --     end
  --     vim.list_extend(opts.ensure_installed, { "gopls", "golangci-lint" })
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- lua_ls = { mason = false },
        -- marksman = { mason = false },
        nil_ls = { mason = false },
        -- rust_analyzer = { mason = false },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "npm install",
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
}
