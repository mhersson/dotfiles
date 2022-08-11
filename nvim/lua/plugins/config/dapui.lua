local status_ok, dapui = pcall(require, "dapui")
if not status_ok then return end

dapui.setup()

function Start_debug()
  require("dapui").open()
  require('dap').continue()
end
