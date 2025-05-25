return {
    cmd = {
        "mpls",
        "--dark-mode",
        "--enable-emoji",
        "--enable-footnotes",
        "--plantuml-server",
        "localhost:8080",
        "--plantuml-path",
        "/",
        "--plantuml-disable-tls",
    },
    root_markers = { ".marksman.toml", ".git" },
    filetypes = { "markdown", "makdown.mdx" },
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "MplsOpenPreview", function()
            local params = {
                command = "open-preview",
                arguments = {},
            }
            client.request("workspace/executeCommand", params, function(err, _)
                if err then
                    vim.notify("Error executing command: " .. err.message, vim.log.levels.ERROR)
                else
                    vim.notify("Preview opened", vim.log.levels.INFO)
                end
            end)
        end, {
            desc = "Open Markdown Preview with mpls",
        })
    end,
}
