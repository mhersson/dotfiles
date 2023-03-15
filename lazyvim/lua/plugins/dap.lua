return {
  {
    "leoluz/nvim-dap-go",
    config = true,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function(_, opts)
      require("dapui").setup(opts)
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "ﳁ", texthl = "DiagnosticError", linehl = "", numhl = "" }
      )
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticWarning", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "", numhl = "" })
    end,
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Start/Continue",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dt",
        function()
          require("dap-go").debug_test()
        end,
        desc = "Debug Test",
      },
      {
        "<leader>dl",
        function()
          require("dap-go").debug_last_test()
        end,
        desc = "Debug Last Test",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle UI",
      },
    },
  },
}
