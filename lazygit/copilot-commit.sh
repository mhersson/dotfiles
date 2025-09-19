#!/usr/bin/env bash

prompt="You are an expert software engineer and meticulous code reviewer. Your task is to generate a single Git commit message that strictly follows the Conventional Commits v2.0.0 Specification. Your primary goal is to produce one short, complete commit message for the staged changes. The summary (first) line must be imperative, present tense, ≤72 characters, and **must not** end with a period. Wrap all body lines at a maximum of 72 characters.If a body is included, format it as a clean, concise bullet list, each line starting with - . The summary line must always contain a scope, e.g. feat(nvim): updated copilot chat prompts."

printf '\n\n' | gh copilot suggest -t shell "${prompt}: $(git diff --staged)" >/dev/null
