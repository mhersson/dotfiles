# 🚀 Neovim Configuration

A clean, modular Neovim configuration built from scratch with inspiration from
LazyVim. Optimized for Go development and leveraging Neovim 0.11's native LSP
capabilities.

## ✨ Features

- **Native LSP**: Uses Neovim 0.11's built-in `vim.lsp.enable()` - no lspconfig
  plugin needed
- **Modular Structure**: Clean separation with `config/`, `plugins/`, `lsp/`,
  and `utils/` directories
- **Go-First Development**: Full Go tooling with gopls, golangci-lint,
  debugging, and testing
- **Markdown Tooling**: Live browser preview with
  [mpls](https://github.com/mhersson/mpls), completion with marksman, and
  linting via markdownlint-cli2
- **Blazing Fast**: blink.cmp completion with SIMD fuzzy matching, lazy loading,
  and optimized startup
- **Modern Pickers**: Snacks.nvim picker combining Telescope's features with
  fzf-lua's speed
- **Developer Tools**: Integrated debugging (DAP), testing (Neotest), git
  workflows (Neogit), and AI assistance (Copilot)
- **Beautiful UI**: Catppuccin/TokyoNight themes, Lualine statusline,
  Bufferline, and Noice UI enhancements

## ⚡️ Requirements

| Requirement    | Minimum Version / Notes             |
| -------------- | ----------------------------------- |
| **Neovim**     | 0.11.0+ (uses native LSP API)       |
| **Git**        | 2.19.0+                             |
| **Nerd Font**  | 3.0+ (for icons)                    |
| **C compiler** | For building Treesitter parsers     |
| **curl**       | For blink.cmp Rust binary downloads |
| **ripgrep**    | For live grep and search            |
| **fd**         | For file finding                    |
| **Terminal**   | True color support required         |

### Optional Tools

| Tool             | Purpose                       |
| ---------------- | ----------------------------- |
| **lazygit**      | Enhanced git TUI              |
| **delta**        | Better git diffs              |
| **stylua**       | Lua formatting                |
| **prettier**     | JS/TS/CSS/Markdown formatting |
| **shfmt**        | Shell script formatting       |
| **shellcheck**   | Shell script linting          |
| **markdownlint** | Markdown linting              |

## 📦 Core Plugins

### Essential Infrastructure

<!--markdownlint-disable MD013 -->

| Plugin           | Purpose                  | Why This One?                                      |
| ---------------- | ------------------------ | -------------------------------------------------- |
| **lazy.nvim**    | Plugin manager           | Fast, modern, lazy loading                         |
| **snacks.nvim**  | QoL utilities collection | Picker, terminal, notifications, explorer, toggles |
| **mini.icons**   | Icon provider            | Faster than nvim-web-devicons with better caching  |
| **plenary.nvim** | Lua utility library      | Required dependency for many plugins               |

### Code Intelligence

| Plugin               | Purpose            | Why This One?                                             |
| -------------------- | ------------------ | --------------------------------------------------------- |
| **blink.cmp**        | Completion engine  | 6x faster than fzf, SIMD fuzzy matching, 0.5-4ms overhead |
| **nvim-treesitter**  | Syntax parsing     | Native 0.11 integration with auto-start                   |
| **copilot.lua**      | AI code completion | GitHub Copilot integration                                |
| **CopilotChat.nvim** | AI chat interface  | Claude Sonnet 4 powered commit messages                   |

### Code Quality

| Plugin                 | Purpose           | Why This One?                                       |
| ---------------------- | ----------------- | --------------------------------------------------- |
| **conform.nvim**       | Formatting        | Modern, extensible, format-on-save                  |
| **nvim-lint**          | Linting           | Async linting with extensive language support       |
| **trouble.nvim**       | Diagnostics UI    | Beautiful diagnostics, quickfix, and LSP references |
| **todo-comments.nvim** | TODO highlighting | Track TODO/FIXME/NOTE comments                      |

### Git Integration

| Plugin            | Purpose         | Why This One?                              |
| ----------------- | --------------- | ------------------------------------------ |
| **gitsigns.nvim** | Git decorations | Inline blame, hunk operations, sign column |
| **neogit**        | Git interface   | Magit-inspired Git UI                      |
| **diffview.nvim** | Diff viewer     | Side-by-side diffs and merge conflicts     |

### Testing & Debugging

| Plugin             | Purpose          | Why This One?                 |
| ------------------ | ---------------- | ----------------------------- |
| **neotest**        | Test runner      | Unified testing interface     |
| **neotest-golang** | Go test adapter  | Go-specific test integration  |
| **nvim-dap**       | Debug adapter    | DAP protocol support          |
| **nvim-dap-go**    | Go debugging     | Delve integration             |
| **nvim-dap-ui**    | Debug UI         | Beautiful debug interface     |
| **nvim-coverage**  | Coverage display | Inline coverage visualization |

### UI & UX

| Plugin                   | Purpose          | Why This One?                               |
| ------------------------ | ---------------- | ------------------------------------------- |
| **lualine.nvim**         | Statusline       | Fast, configurable, extensive components    |
| **bufferline.nvim**      | Buffer tabs      | Visual buffer management                    |
| **which-key.nvim**       | Keybinding hints | Discover and remember keybindings           |
| **noice.nvim**           | Enhanced UI      | Better cmdline, messages, and notifications |
| **render-markdown.nvim** | Markdown preview | Real-time markdown rendering                |

### Project Management

| Plugin                     | Purpose             | Why This One?                       |
| -------------------------- | ------------------- | ----------------------------------- |
| **neovim-project**         | Project management  | Auto-switching with session support |
| **neovim-session-manager** | Session management  | Automatic session handling          |
| **direnv.vim**             | Environment loading | Project-specific env vars           |

<!--markdownlint-enbable MD013 -->

### Themes

| Plugin              | Purpose                  |
| ------------------- | ------------------------ |
| **catppuccin**      | Catppuccin color scheme  |
| **tokyonight.nvim** | Tokyo Night color scheme |
| **gruvbox.nvim**    | Gruvbox color scheme     |

## 🗂️ Structure

```text
nvim/
├── init.lua              # Entry point - loads config & LSP
├── lazy-lock.json        # Plugin version lockfile
├── lsp/                  # Native Neovim 0.11 LSP configs
│   ├── bashls.lua
│   ├── gopls.lua
│   ├── lua_ls.lua
│   ├── marksman.lua
│   ├── mpls.lua
│   ├── regal.lua
│   ├── ts_ls.lua
│   └── yamlls.lua
├── lua/
│   ├── config/           # Core configuration
│   │   ├── init.lua      # Loads all config modules
│   │   ├── options.lua   # Neovim options
│   │   ├── keymaps.lua   # Global keymaps
│   │   ├── autocmds.lua  # Autocommands
│   │   └── lazy.lua      # Lazy.nvim bootstrap
│   ├── plugins/          # Plugin specifications (lazy.nvim)
│   │   ├── blink-cmp.lua
│   │   ├── bufferline.lua
│   │   ├── colorscheme.lua
│   │   ├── copilot.lua
│   │   ├── copilot-chat.lua
│   │   ├── coverage.lua
│   │   ├── dap.lua
│   │   ├── diagnostics.lua
│   │   ├── direnv.lua
│   │   ├── formatting.lua
│   │   ├── gitsigns.lua
│   │   ├── linting.lua
│   │   ├── lualine.lua
│   │   ├── markdown.lua
│   │   ├── neogit.lua
│   │   ├── neotest.lua
│   │   ├── noice.lua
│   │   ├── projects.lua
│   │   ├── search-replace.lua
│   │   ├── sidekick.lua
│   │   ├── snacks.lua
│   │   ├── treesitter.lua
│   │   └── which-key.lua
│   └── utils/            # Utility modules
│       ├── icons.lua
│       └── root.lua
```

## 🎯 Language Support

### Production Languages

| Language     | LSP                  | Formatters         | Linters           | DAP            | Tests          |
| ------------ | -------------------- | ------------------ | ----------------- | -------------- | -------------- |
| **Go**       | gopls, golangci-lint | goimports, gofumpt | golangci-lint     | delve (dap-go) | neotest-golang |
| **Lua**      | lua_ls               | stylua             | -                 | -              | -              |
| **Bash**     | bashls               | shfmt              | shellcheck        | -              | -              |
| **Markdown** | marksman, mpls       | prettier           | markdownlint-cli2 | -              | -              |
| **Rego**     | regal                | -                  | regal             | -              | -              |
| **YAML**     | yamlls               | yamlfmt            | -                 | -              | -              |

### Web Development

| Language                  | LSP   | Formatters |
| ------------------------- | ----- | ---------- |
| **TypeScript/JavaScript** | ts_ls | prettier   |
| **HTML**                  | -     | prettier   |
| **CSS**                   | -     | prettier   |
| **JSON**                  | -     | prettier   |

### Parsers (Treesitter)

bash, c, comment, diff, dockerfile, gitcommit, go, gomod, gosum, gotmpl, gowork,
html, javascript, jsdoc, json, jsonc, lua, luadoc, luap, make, markdown,
markdown_inline, nix, nu, printf, python, regex, rego, rust, toml, tsx,
typescript, vim, vimdoc, xml, yaml, zig

## ⌨️ Key Bindings

**Leader Key:** `<Space>` **Local Leader:** `\`

### Core Navigation

| Key               | Mode   | Action                 |
| ----------------- | ------ | ---------------------- |
| `<C-h/j/k/l>`     | Normal | Navigate windows       |
| `<S-h>` / `<S-l>` | Normal | Previous/Next buffer   |
| `<leader>e`       | Normal | File explorer (Snacks) |

### Finding & Searching

| Key               | Mode          | Action              |
| ----------------- | ------------- | ------------------- |
| `<leader><space>` | Normal        | Smart find files    |
| `<leader>,`       | Normal        | Buffers             |
| `<leader>/`       | Normal        | Live grep           |
| `<leader>ff`      | Normal        | Find files          |
| `<leader>fg`      | Normal        | Git files           |
| `<leader>fr`      | Normal        | Recent files        |
| `<leader>sg`      | Normal        | Grep                |
| `<leader>sw`      | Normal/Visual | Grep word/selection |

### Git

| Key           | Mode          | Action                       |
| ------------- | ------------- | ---------------------------- |
| `<leader>gg`  | Normal        | Neogit                       |
| `<leader>gb`  | Normal        | Git branches                 |
| `<leader>gl`  | Normal        | Git log                      |
| `<leader>gs`  | Normal        | Git status                   |
| `<leader>gd`  | Normal        | Git diff                     |
| `<leader>gB`  | Normal/Visual | Git browse (open in browser) |
| `]h` / `[h`   | Normal        | Next/Previous hunk           |
| `<leader>ghs` | Normal/Visual | Stage hunk                   |
| `<leader>ghr` | Normal/Visual | Reset hunk                   |

### LSP

| Key          | Mode   | Action                   |
| ------------ | ------ | ------------------------ |
| `gd`         | Normal | Goto definition          |
| `gD`         | Normal | Goto declaration         |
| `gr`         | Normal | References               |
| `gI`         | Normal | Goto implementation      |
| `gy`         | Normal | Goto type definition     |
| `<leader>ca` | Normal | Code action              |
| `<leader>cr` | Normal | Rename                   |
| `<leader>cd` | Normal | Line diagnostics         |
| `]d` / `[d`  | Normal | Next/Previous diagnostic |
| `]e` / `[e`  | Normal | Next/Previous error      |

### Testing & Debugging

| Key          | Mode   | Action              |
| ------------ | ------ | ------------------- |
| `<leader>tt` | Normal | Run nearest test    |
| `<leader>tT` | Normal | Run all tests       |
| `<leader>ts` | Normal | Toggle test summary |
| `<leader>to` | Normal | Test output panel   |
| `<leader>db` | Normal | Toggle breakpoint   |
| `<leader>dc` | Normal | Continue            |
| `<leader>di` | Normal | Step into           |
| `<leader>do` | Normal | Step over           |
| `<leader>dO` | Normal | Step out            |
| `<leader>dr` | Normal | REPL                |
| `<leader>du` | Normal | Toggle DAP UI       |

### AI (Copilot)

| Key          | Mode   | Action                  |
| ------------ | ------ | ----------------------- |
| `<leader>at` | Normal | Toggle Copilot          |
| `<leader>ag` | Normal | Generate commit message |

### UI Toggles

| Key          | Mode   | Action                  |
| ------------ | ------ | ----------------------- |
| `<leader>uf` | Normal | Toggle format on save   |
| `<leader>us` | Normal | Toggle spelling         |
| `<leader>uw` | Normal | Toggle wrap             |
| `<leader>ul` | Normal | Toggle line numbers     |
| `<leader>uL` | Normal | Toggle relative numbers |
| `<leader>ud` | Normal | Toggle diagnostics      |
| `<leader>uh` | Normal | Toggle inlay hints      |
| `<leader>uG` | Normal | Toggle git signs        |

### Projects & Sessions

| Key          | Mode   | Action                |
| ------------ | ------ | --------------------- |
| `<leader>pp` | Normal | Browse projects       |
| `<leader>pr` | Normal | Recent projects       |
| `<leader>pq` | Normal | Open previous session |

### Misc

| Key         | Mode   | Action                |
| ----------- | ------ | --------------------- |
| `<leader>l` | Normal | Lazy (plugin manager) |
| `<leader>z` | Normal | Zen mode              |
| `<leader>Z` | Normal | Zoom window           |
| `<C-/>`     | Normal | Toggle terminal       |
| `<leader>?` | Normal | Show buffer keymaps   |

## 🚀 Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this config
git clone https://github.com/mhersson/dotfiles.git
cp -r ./dotfiles/nvim ~/.config/nvim

# Start Neovim (lazy.nvim will auto-install)
nvim

# Install language servers (examples)
# Go
go install golang.org/x/tools/gopls@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Lua
brew install lua-language-server stylua

# Others
npm install -g bash-language-server
npm install -g typescript typescript-language-server
npm install -g prettier
npm install -g markdownlint-cli2
```

## 🔧 Customization

### Adding a New Language Server

Create a file in `lsp/` directory (e.g., `lsp/pyright.lua`):

```lua
return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", ".git" },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
}
```

Then enable it in `init.lua`:

```lua
vim.lsp.enable({
    -- ... existing servers
    "pyright",
})
```

### Adding a New Plugin

Create a file in `lua/plugins/` (e.g., `lua/plugins/example.lua`):

```lua
return {
    {
        "author/plugin-name",
        event = "VeryLazy",  -- or other lazy-loading trigger
        opts = {
            -- plugin options
        },
        keys = {
            { "<leader>x", "<cmd>PluginCommand<cr>", desc = "Description" },
        },
    },
}
```

Lazy.nvim will auto-detect and load it on next restart.

## 📝 Notes

- **LSP Configuration**: This config uses Neovim 0.11's native
  `vim.lsp.enable()` API. No lspconfig plugin needed!
- **Performance**: blink.cmp provides 0.5-4ms completion overhead vs nvim-cmp's
  2-50ms
- **Session Management**: Handled by neovim-project + neovim-session-manager
- **Icons**: Using mini.icons for better performance and caching vs
  nvim-web-devicons

## 🐛 Troubleshooting

### LSP not starting

Check if the language server is installed:

```vim
:checkhealth
```

Verify LSP config exists:

```bash
ls ~/.config/nvim/lsp/
```

### Treesitter parser issues

Update parsers:

```vim
:TSUpdate
```

### Plugin issues

Clean and reinstall:

```vim
:Lazy clean
:Lazy sync
```

## 🤝 Contributing

This is a personal configuration but feel free to:

- Use it as inspiration for your own config
- Report bugs or suggest improvements via issues
- Fork and customize to your needs

## 📄 License

MIT License - Feel free to use and modify as needed.

---

> **Note**: This configuration is actively maintained and updated for the latest
> Neovim features.
