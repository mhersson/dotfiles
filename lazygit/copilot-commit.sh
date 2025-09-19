#!/usr/bin/env bash

read -r -d '' prompt <<'EOF'
You are an expert software engineer and meticulous code reviewer.
Your task is to generate a single Git commit message that strictly follows the Conventional Commits v1.0.0 Specification.
Your primary goal is to produce one short, complete commit message for the staged changes.
The summary (first) line must be imperative, present tense, ≤72 characters, and **must not** end with a period.
Wrap all body lines at a maximum of 72 characters.
If a body is included, format it as a clean, concise bullet list, each line starting with - .
The summary line must always contain a scope, e.g. feat(helix): added new keybinding for lazygit.
If the current branch name contains a jira ticket number on the regexp format '[a-zA-z]{3,4}-[0-9]{3,}', then always use the ticket as the scope in the summary.
Return only the commit message text—no code fences, no commentary, no extra markup or explanations.
EOF

printf '\n\n' | gh copilot suggest -t shell "${prompt}: Current branch: $(git branch --show-current), Diff: $(git diff --staged)" >/dev/null
