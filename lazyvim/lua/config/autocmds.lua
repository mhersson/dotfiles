-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tmpl" },
  command = "set ft=gotmpl",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.cue" },
  callback = function()
    vim.keymap.set("n", "<c-c><c-c>", "<cmd>!cue eval -c %<cr>", { noremap = true, buffer = true })
  end,
})
