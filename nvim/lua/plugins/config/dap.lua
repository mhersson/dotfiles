local status_ok, dap = pcall(require, "dap")
if not status_ok then return end


vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })


dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = { 'dap', '-l', '127.0.0.1:${port}' },
  }
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
-- - `${file}`: Active filename
-- - `${fileBasename}`: The current file's basename
-- - `${fileBasenameNoExtension}`: The current file's basename without extension
-- - `${fileDirname}`: The current file's dirname
-- - `${fileExtname}`: The current file's extension
-- - `${relativeFile}`: The current file relative to |getcwd()|
-- - `${relativeFileDirname}`: The current file's dirname relative to |getcwd()|
-- - `${workspaceFolder}`: The current working directory of Neovim
-- - `${workspaceFolderBasename}`: The name of the folder opened in Neovim

-- Code snippet for asking for input arguments when invoking the debugger:
--
-- args = function()
--   local argument_string = vim.fn.input('Program arguments: ')
--   return vim.fn.split(argument_string, " ", true)
-- end,

-- Arguments can be configured by using the function above or specifying them
-- directly in the array, then source this file before launching the debugger.

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
    args = {},
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}",
    args = {},
  },
  -- works with go.mod packages and sub packages
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
    args = {},
  }
}

vim.keymap.set("n", "<leader>B", "<cmd>lua require'dap'.toggle_breakpoint()<Cr>", { silent = true })
vim.keymap.set("n", "<F5>", "<cmd>lua require'dap'.continue()<Cr>", { silent = true })
vim.keymap.set("n", "<F10>", "<cmd>lua require'dap'.step_over()<Cr>", { silent = true })
vim.keymap.set("n", "<F11>", "<cmd>lua require'dap'.step_into()<Cr>", { silent = true })
vim.keymap.set("n", "<F12>", "<cmd>lua require'dap'.step_out()<Cr>", { silent = true })
