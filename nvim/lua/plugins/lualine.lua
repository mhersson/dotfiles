return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "echasnovski/mini.icons" },
        event = "VeryLazy",
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        opts = function()
            local lualine_require = require("lualine_require")
            lualine_require.require = require

            local icons = require("utils.icons")

            vim.o.laststatus = vim.g.lualine_laststatus

            local opts = {
                options = {
                    theme = "auto",
                    globalstatus = vim.o.laststatus == 3,
                    disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },

                    lualine_c = {
                        {
                            function()
                                local root = vim.fs.find({ ".git", "go.mod" }, { upward = true })[1]
                                if root then
                                    root = vim.fs.dirname(root)
                                    if root ~= vim.fn.getcwd() then
                                        return vim.fn.fnamemodify(root, ":t")
                                    end
                                end
                                return ""
                            end,
                            icon = "󱉭",
                        },
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warn,
                                info = icons.diagnostics.Info,
                                hint = icons.diagnostics.Hint,
                            },
                        },
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                        {
                            "filename",
                            path = 1, -- Show relative path
                            shorting_target = 40,
                            symbols = {
                                modified = "●",
                                readonly = "",
                                unnamed = "[No Name]",
                            },
                        },
                    },
                    lualine_x = {
                        Snacks.profiler.status(),
                        {
                            function()
                                return icons.kinds.Copilot
                            end,
                            cond = function()
                                -- Check for copilot client without relying on package.loaded
                                local clients = vim.lsp.get_clients({ name = "copilot", bufnr = 0 })
                                return #clients > 0
                            end,
                            color = function()
                                local clients = vim.lsp.get_clients({ name = "copilot", bufnr = 0 })
                                if #clients > 0 then
                                    local ok, copilot_status = pcall(require, "copilot.status")
                                    if ok and copilot_status.status and copilot_status.data then
                                        local status = copilot_status.data.status
                                        if status == "InProgress" then
                                            return { fg = "#ff757f" } -- pending/error color
                                        elseif status == "Warning" then
                                            return { fg = "#ff966c" } -- warning color
                                        else
                                            return { fg = "#4fd6be" } -- ok/success color
                                        end
                                    end
                                end
                                return { fg = "#565f89" } -- inactive color
                            end,
                        },
                        -- Add lsp icon if any lsp servers are running
                        {
                            function()
                                local clients = vim.lsp.get_clients({ bufnr = 0 })
                                if #clients > 0 then
                                    return icons.kinds.Lsp .. " " .. #clients
                                end
                                return ""
                            end,
                            cond = function()
                                return #vim.lsp.get_clients({ bufnr = 0 }) > 0
                            end,
                            color = { fg = "#82aaff" },
                        },
                        {
                            function()
                                return "  " .. require("dap").status()
                            end,
                            cond = function()
                                return package.loaded["dap"] and require("dap").status() ~= ""
                            end,
                            color = function()
                                return { fg = Snacks.util.color("Debug") }
                            end,
                        },
                        {
                            "diff",
                            symbols = {
                                added = icons.git.added,
                                modified = icons.git.modified,
                                removed = icons.git.removed,
                            },
                            source = function()
                                local gitsigns = vim.b.gitsigns_status_dict
                                if gitsigns then
                                    return {
                                        added = gitsigns.added,
                                        modified = gitsigns.changed,
                                        removed = gitsigns.removed,
                                    }
                                end
                            end,
                        },
                    },
                    lualine_y = {
                        { "progress", separator = " ", padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                    lualine_z = {
                        function()
                            return " " .. os.date("%R")
                        end,
                    },
                },
                extensions = { "neo-tree", "lazy", "fzf" },
            }

            return opts
        end,
    },
}
