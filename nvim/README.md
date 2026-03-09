# 🚀 Neovim Configuration

A clean, modular Neovim configuration built from scratch with inspiration from
LazyVim. Optimized for Go development and leveraging Neovim 0.11's native LSP
capabilities.

## ✨ Features

- **Native LSP**: Uses Neovim 0.11's built-in `vim.lsp.enable()` - no lspconfig
  plugin needed
- **Modular Structure**: Clean separation with `config/`, `plugins/`, `lsp/`,
  and `utils/` directories
- **Go-First Development**: Full Go tooling with gopls, golangci-lint-langserver,
  debugging, and testing
- **Python Support**: Ruff for linting/formatting and Ty for type checking, both
  via native LSP
- **Markdown Tooling**: Live browser preview with
  [mpls](https://github.com/mhersson/mpls), completion with marksman, and
  linting via markdownlint-cli2
- **Blazing Fast**: blink.cmp completion with SIMD fuzzy matching, lazy loading,
  and optimized startup
- **Modern Pickers**: Snacks.nvim picker combining Telescope's features with
  fzf-lua's speed
- **Developer Tools**: Integrated debugging (DAP), testing (Neotest), git
  workflows (Neogit), and AI assistance (Copilot + Sidekick)
- **Search & Replace**: Powerful project-wide search and replace with grug-far.nvim
- **Beautiful UI**: Everforest theme (6 themes available), Lualine statusline,
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
| **uvx**          | Python tool runner (ruff, ty) |

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
| **friendly-snippets** | Snippet collection | Community-maintained snippets for many languages          |
| **nvim-treesitter**  | Syntax parsing     | Native 0.11 integration with auto-start                   |
| **sidekick.nvim**    | AI CLI assistant   | Integrates Copilot CLI, Claude CLI, and other AI tools    |

### Code Quality

| Plugin                 | Purpose            | Why This One?                                       |
| ---------------------- | ------------------ | --------------------------------------------------- |
| **conform.nvim**       | Formatting         | Modern, extensible, format-on-save                  |
| **nvim-lint**          | Linting            | Async linting with extensive language support        |
| **trouble.nvim**       | Diagnostics UI     | Beautiful diagnostics, quickfix, and LSP references  |
| **todo-comments.nvim** | TODO highlighting  | Track TODO/FIXME/NOTE comments                      |
| **grug-far.nvim**      | Search & replace   | Project-wide search and replace with live preview    |

### Git Integration

| Plugin            | Purpose         | Why This One?                              |
| ----------------- | --------------- | ------------------------------------------ |
| **gitsigns.nvim** | Git decorations | Inline blame, hunk operations, sign column |
| **neogit**        | Git interface   | Magit-inspired Git UI                      |
| **diffview.nvim** | Diff viewer     | Side-by-side diffs and merge conflicts     |

### Testing & Debugging

| Plugin             | Purpose              | Why This One?                 |
| ------------------ | -------------------- | ----------------------------- |
| **neotest**        | Test runner          | Unified testing interface     |
| **neotest-golang** | Go test adapter      | Go-specific test integration  |
| **nvim-dap**       | Debug adapter        | DAP protocol support          |
| **nvim-dap-go**    | Go debugging         | Delve integration             |
| **nvim-dap-ui**    | Debug UI             | Beautiful debug interface     |
| **nvim-dap-virtual-text** | Inline debug values | Shows variable values inline |
| **nvim-coverage**  | Coverage display     | Inline coverage visualization |

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

| Plugin              | Purpose                    |
| ------------------- | -------------------------- |
| **everforest**      | Everforest color scheme    |
| **catppuccin**      | Catppuccin color scheme    |
| **tokyonight.nvim** | Tokyo Night color scheme   |
| **gruvbox.nvim**    | Gruvbox color scheme       |
| **neovim-ayu**      | Ayu color scheme           |
| **onedarkpro.nvim** | One Dark Pro color scheme  |

## 🗂️ Structure

```text
nvim/
├── init.lua              # Entry point - loads config & LSP
├── lazy-lock.json        # Plugin version lockfile
├── lsp/                  # Native Neovim 0.11 LSP configs
│   ├── bashls.lua
│   ├── copilot.lua
│   ├── golangci_lint_ls.lua
│   ├── gopls.lua
│   ├── lua_ls.lua
│   ├── marksman.lua
│   ├── mpls.lua
│   ├── regal.lua
│   ├── ruff.lua
│   ├── ts_ls.lua
│   ├── ty.lua
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

| Language     | LSP                         | Formatters              | Linters           | DAP            | Tests          |
| ------------ | --------------------------- | ----------------------- | ----------------- | -------------- | -------------- |
| **Go**       | gopls, golangci-lint-ls     | goimports, gofumpt      | golangci-lint     | delve (dap-go) | neotest-golang |
| **Python**   | ruff, ty                    | ruff_fix, ruff_format   | ruff              | -              | -              |
| **Lua**      | lua_ls                      | stylua                  | -                 | -              | -              |
| **Bash**     | bashls                      | shfmt                   | shellcheck        | -              | -              |
| **Markdown** | marksman, mpls              | prettier                | markdownlint-cli2 | -              | -              |
| **Rego**     | regal                       | -                       | regal             | -              | -              |
| **YAML**     | yamlls                      | yamlfmt                 | -                 | -              | -              |

### Web Development

| Language                  | LSP   | Formatters |
| ------------------------- | ----- | ---------- |
| **TypeScript/JavaScript** | ts_ls | prettier   |
| **HTML**                  | -     | prettier   |
| **CSS**                   | -     | prettier   |
| **JSON**                  | -     | prettier   |
| **Python**                | -     | prettier   |

### Parsers (Treesitter)

bash, c, comment, diff, dockerfile, gitcommit, go, gomod, gosum, gotmpl, gowork,
html, javascript, jsdoc, json, jsonc, lua, luadoc, luap, make, markdown,
markdown_inline, nix, nu, printf, python, regex, rego, rust, terraform, toml,
tsx, typescript, vim, vimdoc, xml, yaml, zig

## ⌨️ Key Bindings

**Leader Key:** `<Space>` **Local Leader:** `\`

### Core Navigation

| Key               | Mode   | Action                 |
| ----------------- | ------ | ---------------------- |
| `<C-h/j/k/l>`     | Normal | Navigate windows       |
| `<S-h>` / `<S-l>` | Normal | Previous/Next buffer   |
| `<leader>e`       | Normal | File explorer (Snacks) |
| `<leader>bd`      | Normal | Delete buffer          |

### Finding & Searching

| Key               | Mode          | Action              |
| ----------------- | ------------- | ------------------- |
| `<leader><space>` | Normal        | Smart find files    |
| `<leader>,`       | Normal        | Buffers             |
| `<leader>/`       | Normal        | Live grep           |
| `<leader>:`       | Normal        | Command history     |
| `<leader>ff`      | Normal        | Find files          |
| `<leader>fc`      | Normal        | Find config file    |
| `<leader>fg`      | Normal        | Git files           |
| `<leader>fr`      | Normal        | Recent files        |
| `<leader>fp`      | Normal        | Projects            |
| `<leader>sg`      | Normal        | Grep                |
| `<leader>sw`      | Normal/Visual | Grep word/selection |
| `<leader>sb`      | Normal        | Buffer lines        |
| `<leader>ss`      | Normal        | LSP symbols         |
| `<leader>sS`      | Normal        | Workspace symbols   |
| `<leader>sr`      | Normal        | Search & replace    |
| `<leader>sR`      | Normal        | Resume last search  |

### Git

| Key            | Mode          | Action                       |
| -------------- | ------------- | ---------------------------- |
| `<leader>gg`   | Normal        | Lazygit                      |
| `<leader>gb`   | Normal        | Git branches                 |
| `<leader>gl`   | Normal        | Git log                      |
| `<leader>gL`   | Normal        | Git log line                 |
| `<leader>gs`   | Normal        | Git status                   |
| `<leader>gS`   | Normal        | Git stash                    |
| `<leader>gd`   | Normal        | Git diff (hunks)             |
| `<leader>gf`   | Normal        | Git log file                 |
| `<leader>gB`   | Normal/Visual | Git browse (open in browser) |
| `]h` / `[h`    | Normal        | Next/Previous hunk           |
| `]H` / `[H`    | Normal        | Last/First hunk              |
| `<leader>ghs`  | Normal/Visual | Stage hunk                   |
| `<leader>ghr`  | Normal/Visual | Reset hunk                   |
| `<leader>ghS`  | Normal        | Stage buffer                 |
| `<leader>ghu`  | Normal        | Undo stage hunk              |
| `<leader>ghR`  | Normal        | Reset buffer                 |
| `<leader>ghp`  | Normal        | Preview hunk inline          |
| `<leader>ghb`  | Normal        | Blame line                   |
| `<leader>ghB`  | Normal        | Blame buffer                 |
| `<leader>ghd`  | Normal        | Diff this                    |
| `<leader>ghD`  | Normal        | Diff this ~                  |

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

| Key           | Mode          | Action                |
| ------------- | ------------- | --------------------- |
| `<leader>tr`  | Normal        | Run nearest test      |
| `<leader>tt`  | Normal        | Run file tests        |
| `<leader>tT`  | Normal        | Run all test files    |
| `<leader>tl`  | Normal        | Run last test         |
| `<leader>ts`  | Normal        | Toggle test summary   |
| `<leader>to`  | Normal        | Show test output      |
| `<leader>tO`  | Normal        | Toggle output panel   |
| `<leader>tS`  | Normal        | Stop tests            |
| `<leader>tw`  | Normal        | Toggle watch mode     |
| `<leader>tcc` | Normal        | Load coverage         |
| `<leader>tcl` | Normal        | Clear coverage        |
| `<leader>tct` | Normal        | Toggle coverage       |
| `<leader>tcs` | Normal        | Coverage summary      |
| `<leader>dB`  | Normal        | Breakpoint condition  |
| `<leader>db`  | Normal        | Toggle breakpoint     |
| `<leader>da`  | Normal        | Run with args         |
| `<leader>dc`  | Normal        | Run to cursor         |
| `<leader>dd`  | Normal        | Run/Continue          |
| `<leader>di`  | Normal        | Step into             |
| `<leader>dn`  | Normal        | Step over             |
| `<leader>do`  | Normal        | Step out              |
| `<leader>dl`  | Normal        | Run last              |
| `<leader>dP`  | Normal        | Pause                 |
| `<leader>dt`  | Normal        | Terminate             |
| `<leader>dr`  | Normal        | Toggle REPL           |
| `<leader>du`  | Normal        | Toggle DAP UI         |
| `<leader>de`  | Normal/Visual | Eval expression       |
| `<leader>dw`  | Normal        | Widgets               |

### AI (Sidekick)

| Key          | Mode          | Action                  |
| ------------ | ------------- | ----------------------- |
| `<leader>aa` | Normal        | Toggle Sidekick CLI     |
| `<leader>ac` | Normal        | Toggle Copilot CLI      |
| `<leader>aC` | Normal        | Toggle Claude CLI       |
| `<leader>as` | Normal        | Select installed CLI    |
| `<leader>ad` | Normal        | Detach CLI session      |
| `<leader>at` | Normal/Visual | Send selection/code     |
| `<leader>af` | Normal        | Send current file       |
| `<leader>av` | Visual        | Send visual selection   |
| `<leader>ap` | Normal        | Select prompt           |

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
| `<leader>ug` | Normal | Toggle indent guides    |
| `<leader>ub` | Normal | Toggle dark background  |
| `<leader>uc` | Normal | Toggle conceallevel     |
| `<leader>uT` | Normal | Toggle treesitter       |
| `<leader>uD` | Normal | Toggle dim              |
| `<leader>um` | Normal | Toggle markdown render  |
| `<leader>un` | Normal | Dismiss notifications   |

### Diagnostics & Quickfix

| Key          | Mode   | Action                        |
| ------------ | ------ | ----------------------------- |
| `<leader>xx` | Normal | Toggle diagnostics (Trouble)  |
| `<leader>xX` | Normal | Buffer diagnostics            |
| `<leader>cs` | Normal | Symbols (Trouble)             |
| `<leader>cS` | Normal | LSP references/definitions    |
| `<leader>xL` | Normal | Location list (Trouble)       |
| `<leader>xQ` | Normal | Quickfix list (Trouble)       |
| `<leader>xt` | Normal | Todo comments                 |
| `<leader>xT` | Normal | Todo/Fix/Fixme                |
| `<leader>st` | Normal | Search todos                  |
| `<leader>sT` | Normal | Search Todo/Fix/Fixme         |
| `[q` / `]q`  | Normal | Previous/Next trouble item    |
| `[d` / `]d`  | Normal | Previous/Next diagnostic      |
| `[e` / `]e`  | Normal | Previous/Next error           |
| `[t` / `]t`  | Normal | Previous/Next todo comment    |

### Projects & Sessions

| Key          | Mode   | Action                |
| ------------ | ------ | --------------------- |
| `<leader>pp` | Normal | Browse projects       |
| `<leader>fp` | Normal | Browse projects       |
| `<leader>pr` | Normal | Recent projects       |
| `<leader>pq` | Normal | Open previous session |

### Misc

| Key         | Mode   | Action                |
| ----------- | ------ | --------------------- |
| `<leader>l` | Normal | Lazy (plugin manager) |
| `<leader>z` | Normal | Zen mode              |
| `<leader>Z` | Normal | Zoom window           |
| `<C-/>`     | Normal | Toggle terminal       |
| `<leader>.` | Normal | Scratch buffer        |
| `<leader>S` | Normal | Select scratch buffer |
| `<leader>n` | Normal | Notification history  |
| `<leader>cR`| Normal | Rename file           |
| `<leader>?` | Normal | Show buffer keymaps   |
| `<leader>qq`| Normal | Quit all              |

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

# Python (via uvx - no install needed, but for reference)
# uvx ruff check .
# uvx ty check .
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
- **Copilot**: GitHub Copilot runs as a native LSP server
  (`copilot-language-server`), not via a plugin
- **AI Workflows**: Sidekick.nvim provides integration with Copilot CLI,
  Claude CLI, and other AI assistants
- **Performance**: blink.cmp provides 0.5-4ms completion overhead vs nvim-cmp's
  2-50ms
- **Session Management**: Handled by neovim-project + neovim-session-manager
- **Icons**: Using mini.icons for better performance and caching vs
  nvim-web-devicons
- **Python Tooling**: Ruff (linting/formatting) and Ty (type checking) both
  run via `uvx` for zero-install convenience

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
