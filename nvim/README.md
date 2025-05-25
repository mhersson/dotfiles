# 🚀 My Neovim Configuration

My goal is a clean, modular Neovim configuration built from scratch, however it
is very much inspired by LazyVim, but with a focus on Go development and daily
productivity tasks.

This README also function as a to-do list for the features and tools I want to
implement in my setup.

## ✨ Features

- **Modular Structure**: Clean separation of concerns with organized plugin
  management
- **Go-First Development**: Optimized for Go development with gopls,
  golangci-lint, and testing tools
- **Lazy Loading**: Fast startup times with intelligent plugin loading
- **Modern UI**: Beautiful interface with diagnostic icons, statusline, and
  theme support
- **Developer Tools**: Integrated debugging, testing, git workflows, and AI
  assistance

## ⚡️ Requirements

| Requirement    |         Minimum Version / Notes |
| -------------- | ------------------------------: |
| **Neovim**     |                            0.11 |
| **Git**        |                          2.19.0 |
| **NerdFont**   |                             3.0 |
| **C compiler** | For building Treesitter parsers |
| **curl**       |                   For blink.cmp |
| **fzf**        |                    Fuzzy finder |
| **ripgrep**    |                       Live grep |
| **fd**         |                       Find file |
| **Terminal**   |     True color support required |

## 📋 Implementation Status

### 🔧 Core Tools & Utilities

| Tool             | Description                     | Status |
| ---------------- | ------------------------------- | :----: |
| **Lazy**         | Plugin manager                  |   ✅   |
| **Conform**      | Code formatting                 |   ✅   |
| **Copilot**      | AI-powered code completion      |   ✅   |
| **Coverage**     | Test coverage visualization     |   ✅   |
| **Debugger**     | Debug adapter protocol support  |   ✅   |
| **Direnv**       | Environment variable management |   ✅   |
| **Editorconfig** | Consistent coding styles        |   ✅   |
| **Neogit**       | Git interface                   |   ✅   |
| **Neotest**      | Testing framework               |   ✅   |
| **Nvim-lint**    | Linting integration             |   ✅   |
| **Snacks**       | UI enhancements                 |   ✅   |
| **Treesitter**   | Syntax highlighting & parsing   |   ✅   |
| **Which-key**    | Keybinding helper               |   ✅   |

### 💻 Language Support

#### Must Have

| Language     | Tools                         | Status |
| ------------ | ----------------------------- | :----: |
| **Go**       | gopls, golangci-lint          |   ✅   |
| **Markdown** | markdownlint2, marksman, mpls |   ✅   |
| **Rego**     | regal                         |   ✅   |

#### Nice to Have

| Language       | Purpose                   | Status |
| -------------- | ------------------------- | :----: |
| **Bash**       | Shell scripting           |   ✅   |
| **CSS**        | Web styling and design    |   ✅   |
| **HTML**       | Web markup and templates  |   ✅   |
| **Javascript** | Web development           |   ✅   |
| **JSON**       | Data interchange & config |   ✅   |
| **Lua**        | Neovim config             |   ✅   |
| **Python**     | General purpose           |   ⬜   |
| **YAML**       | Configuration files       |   ✅   |

#### Just for Fun

| Language | Status |
| -------- | :----: |
| **Rust** |   ⬜   |
| **Zig**  |   ⬜   |

### 🎨 Color Themes

| Theme               | Status |
| ------------------- | :----: |
| **Catppuccin**      |   ✅   |
| **Gruvbox Light**   |   ⬜   |
| **OneDark**         |   ⬜   |
| **Solarized Light** |   ⬜   |
| **TokyoNight**      |   ✅   |

## 🤝 Contributing

Feel free to suggest improvements or report issues. This configuration is
designed to be personal but can serve as inspiration for others building minimal
Neovim setups.

---

> **Note**: This configuration is actively maintained and regularly updated.
> Check the implementation status table above for the latest feature
> availability.
