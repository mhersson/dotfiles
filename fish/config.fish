# Fish Config - ~/.config/fish/config.fish

# ───────────────────────────────────────────────────────────────
# Shell behavior and preferences
# ───────────────────────────────────────────────────────────────
set -g fish_greeting
set -g fish_key_bindings fish_vi_key_bindings

# XDG directories
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

# Environment
set -gx EDITOR hx
set -gx GOPATH $HOME/Development/go
set -gx HELIX_RUNTIME $HOME/Development/helix/runtime
set -gx BAT_THEME "Everforest Dark"

# PATH
fish_add_path --prepend --move /opt/homebrew/bin
fish_add_path --prepend --move $HOME/.local/bin
fish_add_path --prepend --move $HOME/.cargo/bin
fish_add_path --prepend --move $GOPATH/bin

# Better history search (up/down with what you've typed)
bind -M insert \e\[A history-search-backward
bind -M insert \e\[B history-search-forward

# ───────────────────────────────────────────────────────────────
# Custom prompt (overridden by starship when interactive)
# ───────────────────────────────────────────────────────────────
function fish_prompt
    set -l last_status $status

    set_color blue
    echo -n (string replace -r "^$HOME" '~' $PWD)
    set_color normal

    if git rev-parse --git-dir >/dev/null 2>&1
        set_color green
        echo -n ' on '(git branch --show-current)

        set -l git_status ""
        set_color red

        set -l is_dirty (git diff --quiet 2>/dev/null; echo $status)
        set -l has_staged (git diff --cached --quiet 2>/dev/null; echo $status)
        set -l has_untracked (git ls-files --others --exclude-standard | string collect)

        if test $is_dirty -ne 0
            set git_status $git_status"!"
        end

        if test $has_staged -ne 0
            set git_status $git_status"+"
        end

        if test -n "$has_untracked"
            set git_status $git_status"?"
        end

        if test -n "$git_status"
            echo -n ' ['$git_status']'
        end

        set_color normal
    end

    echo ""

    if test $last_status -eq 0
        set_color green
    else
        set_color red
    end
    echo -n '❯ '
    set_color normal
end

# ───────────────────────────────────────────────────────────────
# Prompt and navigation integrations
# ───────────────────────────────────────────────────────────────
if status is-interactive
    fzf --fish | source
    direnv hook fish | source
    zoxide init --cmd cd fish | source
    starship init fish | source
end

# ───────────────────────────────────────────────────────────────
# Functions
# ───────────────────────────────────────────────────────────────

function cat --wraps=bat --description 'bat with plain style'
    command bat --theme $BAT_THEME --style plain --paging=never $argv
end

function less --wraps=bat --description 'bat with plain style and paging'
    command bat --theme $BAT_THEME --style plain $argv
end

# Update, list outdated, upgrade, and cleanup Homebrew packages
function bup --description 'Update Homebrew and all packages'
    brew update && brew outdated && brew upgrade && brew cleanup
end

# Generate and copy commit message to clipboard
function gg --description 'Generate and copy commit message'
    gitmsg | pbcopy
end

# Helix wrapper: cd into directory and set wezterm tab title
function hx --wraps=hx --description 'Helix editor with auto-cd for directories'
    if test (count $argv) -eq 1 -a -d $argv[1]
        cd $argv[1]
        set -l project (basename (realpath $argv[1]))
        printf '\e]0;hx %s\e\\' $project
        command hx .
        printf '\e]0;\e\\'
    else
        command hx $argv
    end
end

# Decode and pretty-print a JWT token
function jd --description 'Decode and pretty-print a JWT token'
    if test -z "$argv[1]"
        echo "Usage: jd <token>"
        return 1
    end
    go-jwx decode "$argv[1]" | bat --theme $BAT_THEME -l json --style plain
end

# ───────────────────────────────────────────────────────────────
# Aliases
# ───────────────────────────────────────────────────────────────

# Git shortcuts
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias glp='git log --decorate --patch --word-diff=color --color-moved'
alias gria='git rebase --interactive --autosquash'
alias gst='git status'

# Kubernetes shortcuts
alias kc='kubectl'
alias kcl='kubectl logs'
alias kcrr='kubectl rollout restart'

# Tool replacements and shortcuts
alias lg='lazygit'
alias vi='hx'
alias emacs='emacs -nw'
alias gei='curl --silent https://icanhazip.com'
alias yy='yazi'
alias ytop='ytop --human-readable --simple --sel-bg "#82aaff" --sel-fg "#222436"'
