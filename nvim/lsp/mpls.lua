-- ~/.config/nvim/lsp/mpls.lua
---@type vim.lsp.Config
return {
    cmd = {
        "mpls",
        "--no-auto",
        "--theme",
        "everforest-dark",
        "--enable-emoji",
        "--enable-footnotes",
    },
    root_markers = { ".marksman.toml", ".git" },
    filetypes = { "markdown", "markdown.mdx" },
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "MplsOpenPreview", function()
            client:exec_cmd({
                title = "Preview markdown with mpls",
                command = "open-preview",
            })
        end, { desc = "Preview markdown with mpls" })

        vim.keymap.set("n", "<leader>mp", "<cmd>MplsOpenPreview<cr>", {
            buffer = bufnr,
            desc = "Markdown Preview",
        })
    end,
}
