function fish_prompt
    # Capture exit status immediately
    set -l last_status $status

    set_color blue
    echo -n (string replace -r "^$HOME" '~' $PWD)
    set_color normal

    if git rev-parse --git-dir >/dev/null 2>&1
        set_color green
        echo -n ' on '(git branch --show-current)

        # Git status indicators
        set -l git_status ""
        set_color normal

        set_color red
        # Check for various states
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

        # Show status in brackets if any
        if test -n "$git_status"
            echo -n ' ['$git_status']'
        end

        set_color normal
    end

    echo ""

    # Red prompt if last command failed, green otherwise
    if test $last_status -eq 0
        set_color green
    else
        set_color red
    end
    echo -n '❯ '
    set_color normal
end

# Disable greeting
set -g fish_greeting
# Use vi key bindings
set -g fish_key_bindings fish_vi_key_bindings

set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

set -gx EDITOR hx
set -gx GOPATH $HOME/Development/go
set -gx HELIX_RUNTIME $HOME/Development/helix/runtime

# Better history search (up/down with what you've typed)
bind -M insert \e\[A history-search-backward
bind -M insert \e\[B history-search-forward

fish_add_path --prepend --move /opt/homebrew/bin
fish_add_path --prepend --move $HOME/.local/bin
fish_add_path --prepend --move $HOME/.cargo/bin
fish_add_path --prepend --move $GOPATH/bin

# Git
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias glp='git log --decorate --patch --word-diff=color --color-moved'
alias gria='git rebase --interactive --autosquash'
alias gst='git status'
alias gg='gitmsg | pbcopy'

# Kubernetes
alias kc='kubectl'
alias kcl='kubectl logs'
alias kcrr='kubectl rollout restart'

alias cat='bat --theme "Catppuccin Macchiato" --style plain --paging=never'
alias less='bat --theme "Catppuccin Macchiato" --style plain'
alias lg='lazygit'
alias vi='hx'
alias emacs='emacs -nw'
alias gei='curl --silent https://icanhazip.com'
alias yy='yazi'
alias ytop='ytop --human-readable --simple --sel-bg "#82aaff" --sel-fg "#222436"'

if status is-interactive
    fzf --fish | source
    direnv hook fish | source
    zoxide init --cmd cd fish | source
    # starship init fish | source
end
