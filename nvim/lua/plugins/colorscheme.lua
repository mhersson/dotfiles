return {
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavor = "mocha",
            })
            vim.cmd.colorscheme("catppuccin")
        end,
        opts = {
            integrations = {
                aerial = false,
                alpha = false,
                cmp = false,
                dashboard = false,
                flash = false,
                fzf = false,
                grug_far = false,
                gitsigns = true,
                headlines = false,
                illuminate = false,
                indent_blankline = { enabled = true },
                leap = false,
                lsp_trouble = true,
                mason = false,
                markdown = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = false,
                noice = true,
                notify = true,
                semantic_tokens = true,
                snacks = true,
                telescope = false,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        },
        specs = {
            {
                "akinsho/bufferline.nvim",
                optional = true,
                opts = function(_, opts)
                    if (vim.g.colors_name or ""):find("catppuccin") then
                        opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
                    end
                end,
            },
        },
    },
}
