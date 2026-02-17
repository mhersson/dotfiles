# Nushell Config - ~/.config/nushell/config.nu

# ───────────────────────────────────────────────────────────────
# Shell behavior and preferences
# ───────────────────────────────────────────────────────────────
$env.config = {
    show_banner: false
    history: {
        max_size: 10000
        sync_on_enter: true
        file_format: "plaintext"
    }
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "prefix"
        external: {
            enable: true
            completer: { |spans| carapace $spans.0 nushell ...$spans | from json }
        }
    }
    edit_mode: vi
    cursor_shape: {
        vi_insert: line
        vi_normal: block
    }
    color_config: {
        shape_external: green
        shape_internalcall: green
    }
    keybindings: [
        {
            name: edit_command
            modifier: alt
            keycode: char_v
            mode: [vi_normal, vi_insert]
            event: {send: OpenEditor}
        }
    ]
    hooks: {
        env_change: {
            PWD: [
                {code: "
                    if (which direnv | is-not-empty) {
                        let direnv = (direnv export json | from json | default {})
                        $direnv | load-env
                    }
                "}
            ]
        }
    }
}

# Prompt and navigation integrations
source ($nu.data-dir | path join "vendor/autoload/starship.nu")
source ~/.config/nushell/zoxide.nu
# source ~/.config/nushell/themes/tokyonight-moon.nu

# ───────────────────────────────────────────────────────────────
# Functions
# ───────────────────────────────────────────────────────────────

# Run a single Go test by name, optionally in a specific path
def go_single_test [testname: string, testpath: string = ./...] {
    if ($testname | is-empty) {
        print "Please provide a test name to run."
        return
    }
    go test -v -run $testname $testpath
}

alias gtst = go_single_test

# Helix wrapper: cd into directory and set wezterm tab title
def --env --wrapped hx [...args] {
    if ($args | length) == 1 and ($args.0 | path type) == "dir" {
        cd $args.0
        let cwd = ($args.0 | path expand)
        print -n $"\e]7;file://localhost($cwd)\e\\"
        ^hx .
    } else { ^hx ...$args }
}

# Decode and pretty-print a JWT token
def jd [token: string] {
    if ($token == "") {
        echo "Usage: jwksdecode <token>" | stub
        return
    }
    let cmd = $"go-jwx decode \"($token)\" | bat -l json --style plain"
    sh -c $cmd
}

# Update, list outdated, upgrade, and cleanup Homebrew packages
def bup [] {
    brew update
    brew outdated
    brew upgrade
    brew cleanup
}

# ───────────────────────────────────────────────────────────────
# Aliases
# ───────────────────────────────────────────────────────────────

# Directory listing shortcuts
alias l = ls
alias ll = ls -l
alias la = ls -a
alias .. = cd ..

# Use zoxide for smart directory jumping
alias cd = z

# Git shortcuts
alias ga = git add
alias gaa = git add --all
alias gc = git commit -v
alias glp = git log --decorate --patch --word-diff=color --color-moved
alias gria = git rebase --interactive --autosquash
alias gst = git status
alias gg = gitmsg | pbcopy

# Tool replacements and shortcuts
alias cat = bat --theme "base16" --style plain --paging=never
alias less = bat --theme "base16" --style plain
alias lg = lazygit
alias vi = hx
alias emacs = emacs -nw
alias gei = curl --silent https://icanhazip.com
alias kc = kubectl
alias kcl = kubectl logs
alias kcrr = kubectl rollout restart
alias yy = yazi
alias ytop = ytop --human-readable --simple --sel-bg "#82aaff" --sel-fg "#222436"
