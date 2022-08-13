vim.api.nvim_create_augroup("_editing", { clear = true })

-- Enable spell check and word wrap for certain file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "_editing",
  pattern = { "*.txt", "*.md", "*.tex" },
  callback = function()
    vim.cmd("setlocal spell")
    vim.cmd("setlocal wrap")
  end,
})

-- Prevent IndentLine from hiding ``` in markdown files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "_editing",
  pattern = { "*.md", "*.markdown" },
  callback = function()
    vim.g["indentLine_enabled"] = "0"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = "_editing",
  pattern = "markdown",
  callback = function()
    vim.g["indentLine_enabled"] = "0"
  end,
})

-- Set all tmpl files to to gohtmltmpl to enable syntax highlighting
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "_editing",
  pattern = "*.tmpl",
  callback = function()
    vim.bo["filetype"] = "gohtmltmpl"
  end,
})

-- Set filetype for conf files. This is basically just to get the colorizer
-- plugin to work in conf files.
-- https://github.com/norcalli/nvim-colorizer.lua/issues/9#issuecomment-543742619
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  group = "_editing",
  pattern = "*.conf",
  callback = function()
    vim.bo["filetype"] = "conf"
  end,
})
