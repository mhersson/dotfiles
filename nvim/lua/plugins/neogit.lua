return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "folke/snacks.nvim",
        },
        keys = {
            {
                "<leader>gg",
                "<cmd>Neogit kind=split_above<cr>",
                desc = "Neogit",
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
            commit_editor = {
                kind = "split_above"
            },
        },
    },
}
