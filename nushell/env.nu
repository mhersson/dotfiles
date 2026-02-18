# Nushell Environment - ~/.config/nushell/env.nu

# ───────────────────────────────────────────────────────────────
# Core environment
# ───────────────────────────────────────────────────────────────

$env.LC_ALL = "en_US.UTF-8"
$env.EDITOR = "hx"
$env.HELIX_RUNTIME = ($env.HOME | path join "Development" "helix" "runtime")

# XDG directories for consistent config/cache/data locations
$env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.XDG_DATA_HOME = ($env.HOME | path join ".local" "share")
$env.XDG_STATE_HOME = ($env.HOME | path join ".local" "state")

# Go workspace
$env.GOPATH = ($env.HOME | path join "Development" "go")

# ───────────────────────────────────────────────────────────────
# PATH configuration
# ───────────────────────────────────────────────────────────────

# Add Cargo bin if Rust is installed
if ($env.HOME | path join ".cargo" "env" | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | prepend ($env.HOME | path join ".cargo" "bin"))
}

# Prepend tool directories and deduplicate
$env.PATH = ($env.PATH | split row (char esep) | prepend [
    ($env.GOPATH | path join "bin"),
    ($env.HOME | path join ".local" "bin"),
    ($env.HOME | path join ".cargo" "bin"),
    ($env.HOME | path join ".config" "emacs" "bin"),
    "/opt/homebrew/bin"
    "/usr/local/bin"
] | uniq)

# ───────────────────────────────────────────────────────────────
# Tool initialization (run manually after install/update)
# ───────────────────────────────────────────────────────────────

# zoxide init nushell | save -f ~/.config/nushell/zoxide.nu
# starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.CARAPACE_EXCLUDES = "go"
