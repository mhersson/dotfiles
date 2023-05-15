-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "COMMIT_EDITMSG" },
  callback = function()
    vim.keymap.set("n", "<c-c><c-c>", "<cmd>wq<cr>", { noremap = true, buffer = true })
    vim.keymap.set("i", "<c-c><c-c>", "<esc><cmd>wq<cr>", { noremap = true, buffer = true })
  end
})
