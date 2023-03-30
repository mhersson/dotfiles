local M = {
  "nvim-neotest/neotest",
  event = "BufEnter",
  dependencies = {
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-plenary",
    --    "rouge8/neotest-rust",
  },
  keys = {
    {
      "<leader>tt",
      function()
        require("neotest").run.run()
      end,
    },
    {
      "<leader>tm",
      function()
        require("neotest").summary.marked()
      end,
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open()
      end,
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
    },
  },
}

function M.config()
  -- get neotest namespace (api call creates or returns namespace)
  local neotest_ns = vim.api.nvim_create_namespace("neotest")
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
        return message
      end,
    },
  }, neotest_ns)
  require("neotest").setup({
    adapters = {
      require("neotest-go"),
      -- require("neotest-rust"),
    },
  })
end

return M
