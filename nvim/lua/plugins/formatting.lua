return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>uf",
            function()
                local conform = require("conform")

                -- Toggle the format_on_save setting
                if vim.g.format_on_save == false then
                    vim.g.format_on_save = true
                    vim.notify("Format on save enabled", vim.log.levels.INFO)
                else
                    vim.g.format_on_save = false
                    vim.notify("Format on save disabled", vim.log.levels.INFO)
                end
            end,
            desc = "Toggle Format on Save",
        },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            css = { "prettier" },
            go = { "gofumpt", "goimports" },
            html = { "prettier" },
            javascript = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            markdown = { "prettier" },
            python = { "ruff_fix", "ruff_format" },
            sh = { "shfmt" },
            typescript = { "prettier" },
            yaml = { "yamlfmt" },
        },
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
        -- Set up format-on-save
        format_on_save = function(bufnr)
            -- Check the global toggle state
            if vim.g.format_on_save == false then
                return nil
            end

            return {
                timeout_ms = 500,
                lsp_fallback = true,
            }
        end,
        -- Customize formatters
        formatters = {
            prettier = {
                prepend_args = { "--prose-wrap", "always" },
            },
            ruff_fix = {
                command = "uvx",
                args = { "ruff", "check", "--fix", "--select", "I", "-" },
                stdin = true,
            },
            ruff_format = {
                command = "uvx",
                args = { "ruff", "format", "-" },
                stdin = true,
            },
        },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
