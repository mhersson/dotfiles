# Nushell Environment Configuration
# Place this in ~/.config/nushell/env.nu

# Basic environment variables
$env.LC_ALL = "en_US.UTF-8"
$env.EDITOR = "nvim"

# XDG Base Directory Specification
$env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.XDG_DATA_HOME = ($env.HOME | path join ".local" "share")
$env.XDG_STATE_HOME = ($env.HOME | path join ".local" "state")

# Development paths
$env.GOPATH = ($env.HOME | path join "Development" "go")

# Cargo environment (equivalent to sourcing ~/.cargo/env)
if ($env.HOME | path join ".cargo" "env" | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | prepend ($env.HOME | path join ".cargo" "bin"))
}

# PATH configuration with deduplication
$env.PATH = ($env.PATH | split row (char esep) | prepend [
    ($env.GOPATH | path join "bin"),
    ($env.HOME | path join ".local" "bin"),
    ($env.HOME | path join ".cargo" "bin"),
    ($env.HOME | path join ".config" "emacs" "bin"),
    "/opt/homebrew/bin"
] | uniq)

# Initialize zoxide
zoxide init nushell | save -f ~/.config/nushell/zoxide.nu
