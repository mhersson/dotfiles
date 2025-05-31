return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "BufReadPost",
        opts = {
            auth_provider_url = "https://dnb.ghe.com",
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                gitcommit = true,
                help = true,
            },
        },
        config = function(_, opts)
            require("copilot").setup(opts)
            -- Disable Copilot at startup
            vim.defer_fn(function()
                vim.cmd("Copilot disable")
                vim.g.copilot_enabled = 0
            end, 100) -- Small delay to ensure Copilot is fully loaded
        end,
    },
}
