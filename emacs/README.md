# 🚀 Emacs Configuration

A fast, modern, and minimal Emacs configuration optimized for
development work with vim-style keybindings.

## ✨ Features

- **Evil Mode**: Complete vim keybindings with evil-collection for seamless vim experience
- **Modern Completion**: Vertical completion with icons and fuzzy matching
- **Auto-formatting**: Format code on save with language-specific formatters
- **LSP Integration**: Built-in language server support for intelligent code features
- **Project Management**: Projectile integration with treemacs file explorer
- **Git Integration**: Full magit support with visual git gutter
- **AI Assistance**: GitHub Copilot integration for code completion

## 🎯 Core Packages

### Completion & Navigation

- **Vertico**: Vertical completion interface
- **Orderless**: Flexible fuzzy matching
- **Consult**: Enhanced search and navigation commands
- **Corfu**: In-buffer completion with auto-completion
- **Marginalia**: Rich annotations for completions
- **Nerd Icons**: Beautiful icons throughout the interface

### Code Editing & Formatting

- **Apheleia**: Asynchronous code formatting on save
- **Evil**: Vim keybindings with evil-surround and evil-escape
- **Flycheck**: Real-time syntax checking
- **EditorConfig**: Consistent coding styles across projects

### Language Support

- **Eglot**: Built-in LSP client for intelligent code features
- **Tree-sitter**: Modern syntax highlighting and parsing

### Project & Git Management

- **Projectile**: Project management and navigation
- **Magit**: Full-featured Git interface
- **Treemacs**: File explorer with project integration
- **Git Gutter**: Visual git diff indicators

### UI & Themes

- **Catppuccin**: Modern color theme
- **Doom Modeline**: Elegant status line
- **RobotoMono Nerd Font**: Programming font with icons

## 🛠️ Language-Specific Tools

### Go Development

- **gofumpt**: Code formatting (via Apheleia)
- **golangci-lint**: Advanced linting with flycheck-golangci-lint
- **gotest**: Test runner with dedicated keybindings
- **gopls**: Language server for Go

### Markdown

- **MPLS**: Markdown language server with live preview
- **Prettier**: Markdown formatting
- **markdownlint-cli2**: Markdown linting
- Focus tracking for live preview synchronization

### YAML

- **yamlfmt**: YAML formatting
- **yaml-language-server**: YAML language server

### Shell Scripts

- **bash-language-server**: Shell script language server

## 🔧 Special Features

### AI Integration

- **GitHub Copilot**: AI-powered code completion
- Configured for GitHub Enterprise environments
- Custom keybindings for accepting suggestions

### Development Tools

- **Dape**: Debug Adapter Protocol support
- **Vterm**: Full terminal emulator
- **Direnv**: Environment variable management

### Formatting Pipeline

All formatters run automatically on save through Apheleia:

- **gofumpt** for Go files
- **prettier** for Markdown
- **yamlfmt** for YAML files
- Language servers handle imports organization

## 🎨 Theme & UI

- **Catppuccin Macchiato**: Warm, modern color scheme
- **Doom Modeline**: Shows project, git status, LSP info, and more
- **Treemacs**: File explorer with nerd-icons theme
- **Git Gutter**: Visual git diff indicators in the fringe
- **Custom cursor colors**: Different colors for each Evil mode

## 📝 Key Bindings

- **Space**: Leader key for all commands
- **SPC m**: Major mode specific commands
- **SPC tt**: Toggle treemacs
- **SPC p**: Projectile commands
- **ESC**: Exit/quit everything
- **C-RET**: Accept copilot suggestions

The configuration includes mode-specific keybindings for Go testing,
Markdown preview, and more.
