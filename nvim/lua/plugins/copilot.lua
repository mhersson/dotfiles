return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "BufReadPost",
        opts = {
            auth_provider_url = "https://dnb.ghe.com",
            suggestion = { enabled = true },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                gitcommit = true,
                help = true,
            },
        },
    },
}
