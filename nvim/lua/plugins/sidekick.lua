return {
    "folke/sidekick.nvim",
    opts = {
        -- add any options here
        cli = {
            mux = {
                backend = "zellij",
                enabled = false,
            },
            prompts = {
                -- Custom commit message generation prompt
                commit =
                "Generate a single Git commit message that strictly follows the Conventional Commits v1.0.0 Specification",
            },
        },
        tools = {
            claude = { cmd = { "claude" }, url = "https://github.com/anthropics/claude-code" },
            -- codex = { cmd = { "codex", "--search" }, url = "https://github.com/openai/codex" },
            copilot = { cmd = { "copilot", "--banner" }, url = "https://github.com/github/copilot-cli" },
            -- crush = { cmd = { "crush" }, url = "https://github.com/charmbracelet/crush" },
            -- cursor = { cmd = { "cursor-agent" }, url = "https://cursor.com/cli" },
            -- gemini = { cmd = { "gemini" }, url = "https://github.com/google-gemini/gemini-cli" },
            -- grok = { cmd = { "grok" }, url = "https://github.com/superagent-ai/grok-cli" },
            -- opencode = { cmd = { "opencode" }, url = "https://github.com/sst/opencode" },
            -- qwen = { cmd = { "qwen" }, url = "https://github.com/QwenLM/qwen-code" },
        },
    },
    keys = {
        {
            "<tab>",
            function()
                -- if there is a next edit, jump to it, otherwise apply it if any
                if not require("sidekick").nes_jump_or_apply() then
                    return "<Tab>" -- fallback to normal tab
                end
            end,
            expr = true,
            desc = "Goto/Apply Next Edit Suggestion",
        },
        {
            "<c-.>",
            function()
                require("sidekick.cli").focus()
            end,
            mode = { "n", "x", "i", "t" },
            desc = "Sidekick Switch Focus",
        },
        {
            "<leader>aa",
            function()
                require("sidekick.cli").toggle({ focus = true })
            end,
            desc = "Sidekick Toggle CLI",
            mode = { "n", "v" },
        },
        {
            "<leader>ac",
            function()
                require("sidekick.cli").toggle({ name = "copilot", focus = true })
            end,
            desc = "Sidekick Copilot Toggle",
            mode = { "n", "v" },
        },
        {
            "<leader>aC",
            function()
                require("sidekick.cli").toggle({ name = "claude", focus = true })
            end,
            desc = "Sidekick Claude Toggle",
            mode = { "n", "v" },
        },
        {
            "<leader>ag",
            function()
                require("sidekick.cli").ask({ prompt = "commit", submit = true })
            end,
            desc = "Generate commit message",
            mode = { "n", "v" },
        },
        {
            "<leader>ap",
            function()
                require("sidekick.cli").select_prompt()
            end,
            desc = "Sidekick Ask Prompt",
            mode = { "n", "v" },
        },
    },
}
