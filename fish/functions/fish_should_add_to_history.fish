# ~/.config/fish/functions/fish_should_add_to_history.fish
function fish_should_add_to_history
    set -l cmd $argv[1]

    # keep the default "leading space = don't save" escape hatch
    string match -qr '^\s' -- $cmd; and return 1

    set -l blocked \
        '\brm\s+-\S*[rf]' \
        'git\s+reset' \
        'git\s+push\b.*(--force|-f\b)' \
        'git\s+clean\b.*-\S*[fd]' \
        '\bdd\s+if=' \
        '\bmkfs' \
        '>\s*/dev/'

    for pat in $blocked
        string match -qr -- $pat $cmd; and return 1
    end

    return 0
end
