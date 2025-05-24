return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "BufReadPost",
        opts = {
            auth_provider_url = "https://dnb.ghe.com",
            suggestion = {
                enabled = true,
                auto_trigger = false,
                hide_during_completion = true,
                trigger_on_accept = true,
                keymap = {
                    accept = false, -- "<C-CR>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-e>",
                },
            },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
}
