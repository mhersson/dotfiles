local ACTIVE_THEME = "everforest"

-- Catppuccin now comes built in, so no plugin needed
if ACTIVE_THEME == "catppuccin" then
    vim.cmd.colorscheme("catppuccin")
end

return {
    {
        "mhersson/everforest-dark-nvim",
        -- dir = "~/Development/everforest-dark-nvim",
        version = false,
        lazy = ACTIVE_THEME ~= "everforest",
        priority = ACTIVE_THEME == "everforest" and 1000 or nil,
        config = function()
            require("everforest").setup()
            if ACTIVE_THEME == "everforest" then
                vim.cmd.colorscheme("everforest")
            end
        end,
    },
    {
        "shatur/neovim-ayu",
        lazy = ACTIVE_THEME ~= "ayu",
        priority = ACTIVE_THEME == "ayu" and 1000 or nil,
        opts = {
            theme = "ayu",
        },
        config = function(_, opts)
            require("ayu").setup(opts)
            if ACTIVE_THEME == "ayu" then
                vim.cmd.colorscheme("ayu")
            end
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = ACTIVE_THEME ~= "gruvbox",
        priority = ACTIVE_THEME == "gruvbox" and 1000 or nil,
        opts = {
            contrast = "",
        },
        config = function(_, opts)
            require("gruvbox").setup(opts)
            if ACTIVE_THEME == "gruvbox" then
                vim.o.background = "light"
                vim.cmd.colorscheme("gruvbox")
            end
        end,
    },
    {
        "olimorris/onedarkpro.nvim",
        lazy = ACTIVE_THEME ~= "onedark",
        priority = ACTIVE_THEME == "onedark" and 1000 or nil,
        config = function(_, opts)
            require("onedarkpro").setup(opts)
            if ACTIVE_THEME == "onedark" then
                vim.cmd.colorscheme("onelight")
            end
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = ACTIVE_THEME ~= "tokyonight",
        priority = ACTIVE_THEME == "tokyonight" and 1000 or nil,
        opts = { style = "night", transparent = false },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            if ACTIVE_THEME == "tokyonight" then
                vim.cmd.colorscheme("tokyonight")
            end
        end,
    },
}
