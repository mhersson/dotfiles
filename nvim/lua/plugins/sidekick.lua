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
                commit = [[You are an expert software engineer and meticulous code reviewer.
 Your task is to generate a single Git commit message that **strictly follows the Conventional Commits v1.0.0 Specification**

### PRIMARY GOAL
Produce one short, complete commit message for the staged changes.

### OUTPUT FORMAT
- Return **only** the commit message text—no code fences, no commentary, no extra markup or explanations.
- The summary (first) line **must** be imperative, present tense, ≤72 characters, and **must not** end with a period.
- The commit message **must always** end with a blank line, and the summary and the body (if any) must be separated with blank line.
- Wrap all body lines at a maximum of 72 characters.
- If a body is included, format it as a clean, concise bullet list, each line starting with - .
- The summary line **must always** contain a scope, e.g. feat(nvim): Add new AI plugin sidekick.
- If the current branch name contains a jira ticket number on the format [a-zA-Z]{3,4}-[0-9]{3,} - for example IDD-1234
  then use the ticket as the scope in the summary
- If user has COMMIT_EDITMSG opened, generate diff replacement block for the commit message only, and write the commit message.]],
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
