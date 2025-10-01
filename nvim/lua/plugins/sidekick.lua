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
                commit = [[
You are an expert software engineer and meticulous code reviewer.
Your task is to generate a single Git commit message that strictly follows the Conventional Commits v1.0.0 Specification

PRIMARY GOAL:
Produce one short, complete commit message for the staged changes.

RULES:
1. Format: `type(scope): subject` - imperative mood, lowercase, no period
2. Types: feat, fix, docs, style, refactor, test, chore, perf, ci, build, revert
3. Scope: Extract from branch name if contains JIRA ticket (e.g., PROJ-123), otherwise infer from changes
4. Subject: Max 72 chars, describe what the commit does (not did)
5. Body (if needed): Bullet list with `-`, each line max 72 chars, blank line after subject
6. If user has COMMIT_EDITMSG opened, generate diff replacement block for the commit message only

BRANCH NAME PARSING:
- Match pattern: [A-Z]+-\d+ (e.g., JIRA-456, ABC-123)
- If found, use as scope: `feat(JIRA-456): add user authentication`
- If not found, use contextual scope: `fix(api): handle nil pointer`

OUTPUT:
- Return only the commit message
- If COMMIT_EDITMSG buffer exists, replace its contents
- Do not execute git commit
]],
            },
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
