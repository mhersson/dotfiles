return {
    "coffebar/neovim-project",
    opts = {
        projects = { -- define project roots
            "~/Development/*",
            "~/.dotfiles",
            "~/Documents/notes",
            "~/Documents/presentations/*",
        },
        last_session_on_startup = true,
        dashboard_mode = false,
        picker = {
            type = "snacks", -- one of "telescope", "fzf-lua", or "snacks"
        },
    },
    init = function()
        -- enable saving the state of plugins in the session
        vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "folke/snacks.nvim" },
        { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
    keys = {
        {
            "<leader>fp",
            function()
                vim.cmd("NeovimProjectDiscover history")
            end,
            desc = "Browse Projects",
        },
        {
            "<leader>pp",
            function()
                vim.cmd("NeovimProjectDiscover history")
            end,
            desc = "Browse Projects",
        },
        {
            "<leader>pr",
            function()
                vim.cmd("NeovimProjectHistory")
            end,
            desc = "Recent project",
        },
        {
            "<leader>pq",
            function()
                vim.cmd("NeovimProjectLoadRecent")
            end,
            desc = "Open previous session",
        },
    },
}
