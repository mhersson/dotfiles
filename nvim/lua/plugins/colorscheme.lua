local ACTIVE_THEME = "tokyonight"

return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = ACTIVE_THEME ~= "gruvbox",
        priority = ACTIVE_THEME == "gruvbox" and 1000 or nil,
        opts = {
            contrast = "hard",
        },
        config = function(_, opts)
            require("gruvbox").setup(opts)
            if ACTIVE_THEME == "gruvbox" then
                vim.cmd.colorscheme("gruvbox")
            end
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = ACTIVE_THEME ~= "tokyonight",
        priority = ACTIVE_THEME == "tokyonight" and 1000 or nil,
        opts = { style = "moon", transparent = true },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            if ACTIVE_THEME == "tokyonight" then
                vim.cmd.colorscheme("tokyonight")
            end
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = ACTIVE_THEME ~= "catppuccin",
        priority = ACTIVE_THEME == "catppuccin" and 1000 or nil,
        config = function()
            require("catppuccin").setup({
                flavor = "macchiato",
            })
            if ACTIVE_THEME == "catppuccin" then
                vim.cmd.colorscheme("catppuccin")
            end
        end,
        opts = {
            integrations = {
                aerial = false,
                alpha = false,
                cmp = false,
                dashboard = false,
                dap = true,
                dap_ui = true,
                flash = false,
                fzf = true,
                grug_far = true,
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
    },
}
