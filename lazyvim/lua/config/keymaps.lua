-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { silent = true }

-- Dap
vim.keymap.set("n", "<F5>", require("dap").continue, opts)
vim.keymap.set("n", "<F10>", require("dap").step_over, opts)
vim.keymap.set("n", "<F11>", require("dap").step_into, opts)
vim.keymap.set("n", "<F12>", require("dap").step_out, opts)
