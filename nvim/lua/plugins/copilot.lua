return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        lazy = false, -- Load immediately to avoid session restore issues
        opts = {
            auth_provider_url = "https://dnb.ghe.com",
            suggestion = { enabled = true },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                gitcommit = true,
                yaml = true,
                help = true,
            },
        },
        config = function(_, opts)
            require("copilot").setup(opts)

            -- Force Copilot to attach after session load
            vim.api.nvim_create_autocmd("User", {
                pattern = "SessionLoadPost",
                callback = function()
                    vim.defer_fn(function()
                        -- Restart Copilot to ensure it attaches to restored buffers
                        vim.cmd("Copilot disable")
                        vim.defer_fn(function()
                            vim.cmd("Copilot enable")
                        end, 100)
                    end, 200)
                end,
            })
        end,
    },
}
