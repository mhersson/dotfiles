vim.api.nvim_create_augroup("_formatting", { clear = true })

-- Strip trailing whitespaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "_formatting",
  pattern = "*",
  command = "%s/\\s\\+$//e"
})

-- Format on save using the lsp defined formatter
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "_formatting",
  pattern = "*",
  command = "lua vim.lsp.buf.formatting_sync()"
})
-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
