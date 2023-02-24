vim.api.nvim_create_augroup("LspFormatting", { clear = true })
-- Format on save using the lsp defined formatter
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "LspFormatting",
  pattern = "*.go,*.json,*.yaml,*.sh,*.py,*.rs,*.toml",
  callback = function()
    vim.lsp.buf.format()
  end,
})
-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]


-- Organize go imports
function go_org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      end
    end
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = "LspFormatting",
  pattern = "*.go",
  command = "lua go_org_imports()"
})
