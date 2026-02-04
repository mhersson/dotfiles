return {
    {
        "NeogitOrg/neogit",
        enabled = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "folke/snacks.nvim",
        },
        keys = {
            {
                "<leader>gg",
                "<cmd>Neogit kind=tab<cr>",
                desc = "Neogit",
            },
            {
                "<leader>gG",
                function()
                    vim.fn.system("gitmsg | pbcopy")
                end,
                desc = "Generate Git Commit Message",
            },
        },
        opts = {
            -- Do not ask to confirm the commit - just do it when the buffer is closed.
            disable_commit_confirmation = true,
            graph_style = "unicode",
            console_timeout = 4000,
            sections = {
                recent = {
                    folded = false,
                },
            },
            mappings = {
                status = {
                    ["<C-g>"] = function()
                        vim.fn.system("gitmsg | pbcopy")
                        vim.notify("Git message copied to clipboard", vim.log.levels.INFO)
                    end,
                },
            },
        },
    },
}
