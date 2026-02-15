# Nushell Configuration
# Place this in ~/.config/nushell/config.nu

# Configuration
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
    hooks: {
        env_change: {
            PWD: [{
                code: "
                    if (which direnv | is-not-empty) {
                        let direnv = (direnv export json | from json | default {})
                        $direnv | load-env
                    }
                "
            }]
        }
    }
}

# Initialize starship
source ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Initialize zoxide
source ~/.config/nushell/zoxide.nu

# source ~/.config/nushell/themes/tokyonight-moon.nu

# Custom functions
def go_single_test [testname: string, testpath: string = "./..."] {
    if ($testname | is-empty) {
        print "Please provide a test name to run."
        return
    }
    go test -v -run $testname $testpath
}

alias gtst = go_single_test

def --env --wrapped hx [...args] {
    if ($args | length) == 1 and ($args.0 | path type) == "dir" {
        cd $args.0
        let cwd = ($args.0 | path expand)
        print -n $"\e]7;file://localhost($cwd)\e\\"
        ^hx .
    } else {
        ^hx ...$args
    }
}

# Aliases
alias l = ls
alias ll = ls -l
alias la = ls -a
alias .. = cd ..

# Override cd to use zoxide
alias cd = z

# Git aliases
alias ga = git add
alias gaa = git add --all
alias gc = git commit -v
alias glp = git log --decorate --patch --word-diff=color --color-moved
alias gria = git rebase --interactive --autosquash
alias gst = git status
alias gg = gitmsg | pbcopy

# Tool aliases
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

