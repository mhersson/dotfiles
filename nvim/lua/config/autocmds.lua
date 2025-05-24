-- Autocmds

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.go.tmpl" },
    command = "set ft=gotmpl",
})
