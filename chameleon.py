#!/usr/bin/env python3
"""
Chameleon - Theme Switcher for dotfiles

A TUI application to switch color themes across multiple applications.
Uses curses for the interface, no external dependencies required.

Config files are edited in the dotfiles repo regardless of which apps are
installed on this machine, so the repo stays consistent across machines.
System appearance is switched on macOS (osascript) and GNOME (gsettings).
"""

from __future__ import annotations

import curses
import re
import shutil
import subprocess
import sys
from pathlib import Path

# Detect dotfiles directory from script location
DOTFILES_DIR = Path(__file__).parent.resolve()

# Theme definitions with per-app values
# Each theme has: dark (bool), and app-specific values
THEMES = {
    "ayu-mirage": {
        "dark": True,
        "nvim": "ayu",
        "nvim_mirage": True,
        "helix": "ayu_mirage",
        "wezterm": "Ayu Mirage",
        "ghostty": "Ayu Mirage",
        "kitty": "ayu_mirage",
        "zellij": "ayu-mirage",
        # termagit has no ayu theme; tokyo-night-storm's #24283b background is the
        # closest match to mirage's #1f2430
        "termagit": "tokyo-night-storm",
        "k9s": "ayu-mirage",
        # bat ships no ayu theme - TwoDark is the closest match
        "bat": "TwoDark",
        "zed_dark": "Ayu Mirage",
        "zed_light": "Ayu Light",
        # mpls has no ayu-mirage theme - tokyonight-moon's background (#222436)
        # is the closest match to mirage's #1f2430 (ayu-dark is far darker)
        "mpls": "tokyonight-moon",
        "yclock": {"bg": "#1f2430", "fg": "#cccac2", "accent": "#ffcc66"},
        "slack": "#1F2430,#23344B,#73D0FF,#1F2430,#274364,#CCCAC2,#D5FF80,#F28779",
    },
    "catppuccin-mocha": {
        "dark": True,
        "nvim": "catppuccin",
        "nvim_flavor": "mocha",
        "helix": "catppuccin_mocha",
        "wezterm": "Catppuccin Mocha",
        "ghostty": "Catppuccin Mocha",
        "kitty": "Catppuccin-Mocha",
        "zellij": "catppuccin-mocha",
        "termagit": "catppuccin-mocha",
        "k9s": "tokyo-night",
        "bat": "Catppuccin Mocha",
        "zed_dark": "Catppuccin Mocha",
        "zed_light": "Catppuccin Latte",
        "mpls": "catppuccin-mocha",
        "yclock": {"bg": "#1e1e2e", "fg": "#cdd6f4", "accent": "#f5c2e7"},
        "slack": "#1E1E2E,#313244,#89B4FA,#1E1E2E,#45475A,#CDD6F4,#A6E3A1,#F38BA8",
    },
    "catppuccin-macchiato": {
        "dark": True,
        "nvim": "catppuccin",
        "nvim_flavor": "macchiato",
        "helix": "catppuccin_macchiato",
        "wezterm": "Catppuccin Macchiato",
        "ghostty": "Catppuccin Macchiato",
        "kitty": "Catppuccin-Macchiato",
        "zellij": "catppuccin-macchiato",
        "termagit": "catppuccin-macchiato",
        "k9s": "tokyo-night",
        "bat": "Catppuccin Macchiato",
        "zed_dark": "Catppuccin Macchiato",
        "zed_light": "Catppuccin Latte",
        "mpls": "catppuccin-macchiato",
        "yclock": {"bg": "#24273a", "fg": "#cad3f5", "accent": "#f5bde6"},
        "slack": "#24273A,#363A4F,#8AADF4,#24273A,#494D64,#CAD3F5,#A6DA95,#ED8796",
    },
    "catppuccin-frappe": {
        "dark": True,
        "nvim": "catppuccin",
        "nvim_flavor": "frappe",
        "helix": "catppuccin_frappe",
        "wezterm": "Catppuccin Frappe",
        "ghostty": "Catppuccin Frappe",
        "kitty": "Catppuccin-Frappe",
        "zellij": "catppuccin-frappe",
        "termagit": "catppuccin-frappe",
        "k9s": "tokyo-night",
        "bat": "Catppuccin Frappe",
        "zed_dark": "Catppuccin Frappé",
        "zed_light": "Catppuccin Latte",
        "mpls": "catppuccin-frappe",
        "yclock": {"bg": "#303446", "fg": "#c6d0f5", "accent": "#f4b8e4"},
        "slack": "#303446,#414559,#8CAAEE,#303446,#51576D,#C6D0F5,#A6D189,#E78284",
    },
    "catppuccin-latte": {
        "dark": False,
        "nvim": "catppuccin",
        "nvim_flavor": "latte",
        "helix": "catppuccin_latte",
        "wezterm": "Catppuccin Latte",
        "ghostty": "Catppuccin Latte",
        "kitty": "Catppuccin-Latte",
        "zellij": "catppuccin-latte",
        "termagit": "catppuccin-latte",
        "k9s": "catppuccin-latte",
        "bat": "Catppuccin Latte",
        "zed_dark": "Catppuccin Latte",
        "zed_light": "Catppuccin Latte",
        "mpls": "catppuccin-latte",
        "yclock": {"bg": "#eff1f5", "fg": "#4c4f69", "accent": "#ea76cb"},
        "slack": "#EFF1F5,#CCD0DA,#1E66F5,#EFF1F5,#BCC0CC,#4C4F69,#40A02B,#D20F39",
    },
    "gruvbox-light": {
        "dark": False,
        "nvim": "gruvbox",
        "helix": "gruvbox_light",
        "wezterm": "GruvboxLight",
        "ghostty": "Gruvbox Light",
        "kitty": "gruvbox-light",
        "zellij": "gruvbox-light",
        "termagit": "gruvbox-light",
        "k9s": "gruvbox-light",
        "bat": "gruvbox-light",
        "zed_dark": "Gruvbox",
        "zed_light": "Gruvbox Light",
        "mpls": "gruvbox-light",
        "yclock": {"bg": "#fbf1c7", "fg": "#3c3836", "accent": "#d65d0e"},
        "slack": "#FBF1C7,#EBDBB2,#458588,#FBF1C7,#D5C4A1,#3C3836,#79740E,#CC241D",
    },
    "everforest-dark": {
        "dark": True,
        "nvim": "everforest",
        "helix": "my_everforest_dark",
        "wezterm": "Everforest Dark (Gogh)",
        "ghostty": "Everforest Dark Medium",
        "kitty": "everforest_dark_medium",
        "zellij": "everforest-dark",
        "termagit": "everforest-dark",
        "k9s": "everforest-dark",
        "bat": "Everforest Dark",
        "zed_dark": "Everforest Dark Medium",
        "zed_light": "Everforest Light Medium",
        "mpls": "everforest-dark",
        "yclock": {"bg": "#272e33", "fg": "#d2c6aa", "accent": "#ed8796"},
        "slack": "#272E33,#343F44,#7FBBB3,#272E33,#3D484D,#D3C6AA,#A7C080,#E67E80",
    },
    "github-dark": {
        "dark": True,
        "nvim": "github",
        "nvim_variant": "github_dark_default",
        "helix": "github_dark",
        # wezterm only ships the older iTerm2 GitHub Dark (#101216); it is still
        # the closest match to Primer dark's #0d1117
        "wezterm": "GitHub Dark",
        "ghostty": "GitHub Dark Default",
        "kitty": "GitHub_Dark",
        # zellij has no github theme; tokyo-night-dark (#1a1b26) is the closest
        # dark blue-black with blue accents
        "zellij": "tokyo-night-dark",
        # termagit has no github theme; tokyo-night (#1a1b26) is the closest match
        "termagit": "tokyo-night",
        "k9s": "github-dark",
        # bat ships no github dark theme - Coldark-Dark (#111b27) is the closest
        "bat": "Coldark-Dark",
        # both zed themes come from the github-theme extension
        "zed_dark": "GitHub Dark",
        "zed_light": "GitHub Light",
        # mpls' generic dark theme is github dark: #0d1117 background, #c9d1d9 text
        "mpls": "dark",
        "yclock": {"bg": "#0d1117", "fg": "#e6edf3", "accent": "#58a6ff"},
        "slack": "#0D1117,#161B22,#58A6FF,#0D1117,#21262D,#E6EDF3,#3FB950,#F85149",
    },
    "github-light": {
        "dark": False,
        "nvim": "github",
        "nvim_variant": "github_light_default",
        "helix": "github_light",
        # the Gogh variant is the one carrying Primer light's ansi colors; its
        # #f6f8fa background is a shade off github's pure white
        "wezterm": "Github Light (Gogh)",
        "ghostty": "GitHub Light Default",
        "kitty": "GitHub_Light",
        # zellij has no github theme; ayu-light (#e7eaed) is its lightest
        "zellij": "ayu-light",
        # termagit has no github theme; catppuccin-latte (#eff1f5) is the closest
        # to github light's #ffffff
        "termagit": "catppuccin-latte",
        "k9s": "github-light",
        # bat's GitHub theme is the light one
        "bat": "GitHub",
        "zed_dark": "GitHub Dark",
        "zed_light": "GitHub Light",
        # mpls' generic light theme is github light: #ffffff background, #24292e text
        "mpls": "light",
        "yclock": {"bg": "#ffffff", "fg": "#1f2328", "accent": "#0969da"},
        "slack": "#FFFFFF,#F6F8FA,#0969DA,#FFFFFF,#EAEEF2,#1F2328,#1A7F37,#CF222E",
    },
    "tokyonight": {
        "dark": True,
        "nvim": "tokyonight",
        "nvim_style": "night",
        "helix": "tokyonight",
        "wezterm": "Tokyo Night",
        "ghostty": "TokyoNight Night",
        "kitty": "tokyo_night_night",
        # zellij's tokyo-night uses the storm palette; tokyo-night-dark matches the
        # night style's #1a1b26 background
        "zellij": "tokyo-night-dark",
        "termagit": "tokyo-night",
        "k9s": "tokyo-night",
        "bat": "Tokyo Night",
        "zed_dark": "Tokyo Night",
        "zed_light": "Tokyo Night Light",
        "mpls": "tokyonight",
        "yclock": {"bg": "#1a1b26", "fg": "#c0caf5", "accent": "#bb9af7"},
        "slack": "#1A1B26,#292E42,#7AA2F7,#1A1B26,#3B4261,#C0CAF5,#9ECE6A,#F7768E",
    },
    "tokyonight-storm": {
        "dark": True,
        "nvim": "tokyonight",
        "nvim_style": "storm",
        "helix": "tokyonight_storm",
        "wezterm": "Tokyo Night Storm",
        "ghostty": "TokyoNight Storm",
        "kitty": "tokyo_night_storm",
        "zellij": "tokyo-night-storm",
        "termagit": "tokyo-night-storm",
        "k9s": "tokyo-night",
        "bat": "Tokyo Night",
        "zed_dark": "Tokyo Night Storm",
        "zed_light": "Tokyo Night Light",
        "mpls": "tokyonight-storm",
        "yclock": {"bg": "#24283b", "fg": "#c0caf5", "accent": "#bb9af7"},
        "slack": "#24283B,#343A52,#7AA2F7,#24283B,#3B4261,#C0CAF5,#9ECE6A,#F7768E",
    },
    "tokyonight-moon": {
        "dark": True,
        "nvim": "tokyonight",
        "nvim_style": "moon",
        "helix": "tokyonight_moon",
        "wezterm": "Tokyo Night Moon",
        "ghostty": "TokyoNight Moon",
        "kitty": "tokyo_night_moon",
        # zellij has no moon variant; tokyo-night-dark (#1a1b26) is closer to
        # moon's #222436 than tokyo-night-storm is
        "zellij": "tokyo-night-dark",
        # termagit has no moon variant; tokyo-night-storm (#24283b) is closer to
        # moon's #222436 than tokyo-night (#1a1b26) is
        "termagit": "tokyo-night-storm",
        "k9s": "tokyo-night",
        "bat": "Tokyo Night",
        "zed_dark": "Tokyo Night Moon",
        "zed_light": "Tokyo Night Light",
        "mpls": "tokyonight-moon",
        "yclock": {"bg": "#222436", "fg": "#c8d3f5", "accent": "#c099ff"},
        "slack": "#222436,#2F334D,#82AAFF,#222436,#3B4261,#C8D3F5,#C3E88D,#FF757F",
    },
}

# Ordered list of theme names for display
THEME_ORDER = [
    "ayu-mirage",
    "catppuccin-mocha",
    "catppuccin-macchiato",
    "catppuccin-frappe",
    "catppuccin-latte",
    "gruvbox-light",
    "everforest-dark",
    "github-dark",
    "github-light",
    "tokyonight",
    "tokyonight-storm",
    "tokyonight-moon",
]


def update_file_with_regex(
    filepath: Path, pattern: str, replacement: str, flags: int = re.MULTILINE
) -> bool:
    """Update a file by replacing a regex pattern with a replacement string.

    Patterns are matched per-line by default so that ^ anchors work regardless
    of where the setting appears in the file.
    """
    if not filepath.exists():
        return False
    content = filepath.read_text()
    new_content, count = re.subn(pattern, replacement, content, count=1, flags=flags)
    if count > 0:
        filepath.write_text(new_content)
        return True
    return False


def update_nvim(theme: dict) -> bool:
    """Update Neovim colorscheme.lua with theme and optionally flavor/style."""
    filepath = DOTFILES_DIR / "nvim" / "lua" / "plugins" / "colorscheme.lua"
    if not filepath.exists():
        return False

    content = filepath.read_text()

    # Update ACTIVE_THEME on line 1
    content = re.sub(
        r'^local ACTIVE_THEME = ".*"',
        f'local ACTIVE_THEME = "{theme["nvim"]}"',
        content,
        flags=re.MULTILINE,
    )

    # Update catppuccin flavor if applicable
    if theme["nvim"] == "catppuccin" and "nvim_flavor" in theme:
        content = re.sub(
            r'flavor = "[^"]*"',
            f'flavor = "{theme["nvim_flavor"]}"',
            content,
        )

    # Update tokyonight style if applicable
    if theme["nvim"] == "tokyonight" and "nvim_style" in theme:
        content = re.sub(
            r'style = "[^"]*"',
            f'style = "{theme["nvim_style"]}"',
            content,
        )

    # Update ayu mirage variant if applicable
    if theme["nvim"] == "ayu" and "nvim_mirage" in theme:
        content = re.sub(
            r"mirage = (?:true|false)",
            f"mirage = {'true' if theme['nvim_mirage'] else 'false'}",
            content,
        )

    # github-nvim-theme has no dark/light option - the variant is the
    # colorscheme name, so rewrite the colorscheme call instead
    if theme["nvim"] == "github" and "nvim_variant" in theme:
        content = re.sub(
            r'colorscheme\("github_[^"]*"\)',
            f'colorscheme("{theme["nvim_variant"]}")',
            content,
        )

    filepath.write_text(content)
    return True


def update_helix(theme: dict) -> bool:
    """Update Helix config.toml theme."""
    filepath = DOTFILES_DIR / "helix" / "config.toml"
    return update_file_with_regex(
        filepath, r'^theme = ".*"', f'theme = "{theme["helix"]}"'
    )


def update_wezterm(theme: dict) -> bool:
    """Update WezTerm wezterm.lua color_scheme."""
    filepath = DOTFILES_DIR / "wezterm" / "wezterm.lua"
    return update_file_with_regex(
        filepath,
        r'config\.color_scheme = ".*"',
        f'config.color_scheme = "{theme["wezterm"]}"',
    )


def update_ghostty(theme: dict) -> bool:
    """Update Ghostty config theme.

    Anchored at line start so commented-out theme lines are left untouched.
    """
    filepath = DOTFILES_DIR / "ghostty" / "config"
    return update_file_with_regex(
        filepath, r"^theme[ \t]*=.*", f"theme = {theme['ghostty']}"
    )


def update_kitty(theme: dict) -> bool:
    """Update kitty.conf to include the theme file from kitty/themes.

    Theme files are copied from kitty-themes so they exist in the repo even on
    machines without kitty installed.
    """
    filepath = DOTFILES_DIR / "kitty" / "kitty.conf"
    return update_file_with_regex(
        filepath,
        r"^include \./themes/.*\.conf$",
        f"include ./themes/{theme['kitty']}.conf",
    )


def update_zellij(theme: dict) -> bool:
    """Update Zellij config.kdl theme.

    Anchored at line start so the commented theme_dark/theme_light lines are
    left untouched.
    """
    filepath = DOTFILES_DIR / "zellij" / "config.kdl"
    return update_file_with_regex(
        filepath, r'^theme ".*"', f'theme "{theme["zellij"]}"'
    )


def update_termagit(theme: dict) -> bool:
    """Update termagit config.toml theme."""
    filepath = DOTFILES_DIR / "termagit" / "config.toml"
    return update_file_with_regex(
        filepath, r'^theme = ".*"', f'theme = "{theme["termagit"]}"'
    )


def update_k9s(theme: dict) -> bool:
    """Update K9s config.yaml skin."""
    filepath = DOTFILES_DIR / "k9s" / "config.yaml"
    return update_file_with_regex(filepath, r"skin: .*", f"skin: {theme['k9s']}")


def update_bat(theme: dict) -> bool:
    """Update Fish config.fish BAT_THEME.

    Matches the value quoted or not, since fish_indent strips quotes from
    single-word values; it is always written quoted for multi-word names.
    """
    filepath = DOTFILES_DIR / "fish" / "config.fish"
    return update_file_with_regex(
        filepath,
        r"^set -gx BAT_THEME .*",
        f'set -gx BAT_THEME "{theme["bat"]}"',
    )


def update_zed(theme: dict) -> bool:
    """Update Zed settings.json - dark themes update 'dark', light themes update 'light'."""
    filepath = DOTFILES_DIR / "zed" / "settings.json"
    if not filepath.exists():
        return False

    content = filepath.read_text()

    # Zed uses JSONC (JSON with comments), so we use regex replacement
    # Only update the matching mode (dark or light) based on theme type
    if theme["dark"]:
        pattern = r'("theme"\s*:\s*\{[^}]*"dark"\s*:\s*)"[^"]*"'
        content = re.sub(pattern, rf'\1"{theme["zed_dark"]}"', content)
    else:
        pattern = r'("theme"\s*:\s*\{[^}]*"light"\s*:\s*)"[^"]*"'
        content = re.sub(pattern, rf'\1"{theme["zed_light"]}"', content)

    filepath.write_text(content)
    return True


def update_yclock(theme: dict) -> bool:
    """Update yclock.conf colors."""
    filepath = DOTFILES_DIR / "yclock" / "yclock.conf"
    if not filepath.exists():
        return False

    content = filepath.read_text()
    yclock = theme["yclock"]

    # Update background, foreground, and second_hand colors
    content = re.sub(
        r"^background = #[0-9a-fA-F]+",
        f"background = {yclock['bg']}",
        content,
        flags=re.MULTILINE,
    )
    content = re.sub(
        r"^foreground = #[0-9a-fA-F]+",
        f"foreground = {yclock['fg']}",
        content,
        flags=re.MULTILINE,
    )
    content = re.sub(
        r"^second_hand = #[0-9a-fA-F]+",
        f"second_hand = {yclock['accent']}",
        content,
        flags=re.MULTILINE,
    )

    filepath.write_text(content)
    return True


def update_mpls_nvim(theme: dict) -> bool:
    """Update mpls theme in Neovim lsp/mpls.lua."""
    filepath = DOTFILES_DIR / "nvim" / "lsp" / "mpls.lua"
    return update_file_with_regex(
        filepath,
        r'"--theme",\s*"[^"]*"',
        f'"--theme",\n        "{theme["mpls"]}"',
    )


def update_mpls_helix(theme: dict) -> bool:
    """Update mpls theme in Helix languages.toml."""
    filepath = DOTFILES_DIR / "helix" / "languages.toml"
    return update_file_with_regex(
        filepath,
        r'"--theme", "[^"]*"',
        f'"--theme", "{theme["mpls"]}"',
    )


def update_mpls_zed(theme: dict) -> bool:
    """Update mpls theme in Zed settings.json."""
    filepath = DOTFILES_DIR / "zed" / "settings.json"
    return update_file_with_regex(
        filepath,
        r'"--theme",\s*"[^"]*"',
        f'"--theme",\n          "{theme["mpls"]}"',
    )


def _run_quietly(command: list[str]) -> bool:
    """Run a command, returning False if it is missing or exits non-zero."""
    if shutil.which(command[0]) is None:
        return False
    try:
        subprocess.run(command, check=True, capture_output=True)
    except (subprocess.CalledProcessError, OSError):
        return False
    return True


def set_macos_appearance(dark: bool) -> bool:
    """Set macOS system appearance using osascript."""
    appearance = "true" if dark else "false"
    script = f'tell app "System Events" to tell appearance preferences to set dark mode to {appearance}'
    return _run_quietly(["osascript", "-e", script])


def set_gnome_appearance(dark: bool) -> bool:
    """Set GNOME color scheme using gsettings.

    Uses the same values GNOME Settings writes: prefer-dark for dark and
    default for light.
    """
    scheme = "prefer-dark" if dark else "default"
    return _run_quietly(
        ["gsettings", "set", "org.gnome.desktop.interface", "color-scheme", scheme]
    )


def set_os_appearance(dark: bool) -> bool:
    """Set the system light/dark appearance for the current platform."""
    if sys.platform == "darwin":
        return set_macos_appearance(dark)
    if sys.platform.startswith("linux"):
        return set_gnome_appearance(dark)
    return False


def os_appearance_label() -> str:
    """Name shown in the status line when the OS appearance was switched."""
    return "macOS" if sys.platform == "darwin" else "GNOME"


def slack_installed() -> bool:
    """Check whether Slack is installed, via PATH, app bundle, flatpak or snap."""
    if shutil.which("slack") is not None:
        return True
    locations = (
        Path("/Applications/Slack.app"),
        Path("/var/lib/flatpak/app/com.slack.Slack"),
        Path.home() / ".local" / "share" / "flatpak" / "app" / "com.slack.Slack",
        Path("/snap/slack"),
    )
    return any(location.exists() for location in locations)


def detect_current_theme() -> str | None:
    """Detect the currently active theme from the Helix config.

    Every theme maps to a distinct Helix theme name, so the reverse lookup is
    unambiguous.
    """
    helix_path = DOTFILES_DIR / "helix" / "config.toml"
    if not helix_path.exists():
        return None
    match = re.search(r'^theme = "([^"]*)"', helix_path.read_text(), re.MULTILINE)
    if not match:
        return None
    for name, theme in THEMES.items():
        if theme["helix"] == match.group(1):
            return name
    return None


def apply_theme(theme_name: str) -> list[str]:
    """Apply a theme to all applications. Returns list of updated apps."""
    if theme_name not in THEMES:
        return []

    theme = THEMES[theme_name]
    updated = []

    if update_nvim(theme):
        updated.append("Neovim")
    if update_helix(theme):
        updated.append("Helix")
    if update_wezterm(theme):
        updated.append("WezTerm")
    if update_ghostty(theme):
        updated.append("Ghostty")
    if update_kitty(theme):
        updated.append("Kitty")
    if update_zellij(theme):
        updated.append("Zellij")
    if update_termagit(theme):
        updated.append("termagit")
    if update_k9s(theme):
        updated.append("K9s")
    if update_bat(theme):
        updated.append("Bat")
    if update_zed(theme):
        updated.append("Zed")
    if update_yclock(theme):
        updated.append("Yclock")
    if update_mpls_nvim(theme):
        updated.append("mpls-nvim")
    if update_mpls_helix(theme):
        updated.append("mpls-helix")
    if update_mpls_zed(theme):
        updated.append("mpls-zed")
    if set_os_appearance(theme["dark"]):
        updated.append(os_appearance_label())

    return updated


def main(stdscr):
    """Main curses TUI function."""
    # Setup curses
    curses.curs_set(0)  # Hide cursor
    curses.use_default_colors()

    # Initialize color pairs
    curses.init_pair(1, curses.COLOR_BLACK, curses.COLOR_WHITE)  # Selected
    curses.init_pair(2, curses.COLOR_GREEN, -1)  # Current theme marker
    curses.init_pair(3, curses.COLOR_YELLOW, -1)  # Status message

    current_idx = 0
    current_theme = detect_current_theme()
    status_message = ""
    show_slack = slack_installed()

    # Try to select current theme in list
    if current_theme in THEME_ORDER:
        current_idx = THEME_ORDER.index(current_theme)

    while True:
        stdscr.clear()
        height, width = stdscr.getmaxyx()

        # Title
        title = "Chameleon - Theme Switcher"
        stdscr.addstr(1, (width - len(title)) // 2, title, curses.A_BOLD)

        # Instructions
        instructions = "↑/↓: Navigate | Enter: Apply | q: Quit"
        stdscr.addstr(3, (width - len(instructions)) // 2, instructions)

        # Theme list; leave room for the Slack box when shown, and the status line
        start_y = 5
        list_bottom = height - 8 if show_slack else height - 3
        for idx, theme_name in enumerate(THEME_ORDER):
            y = start_y + idx
            if y >= list_bottom:
                break

            # Build display string
            is_dark = THEMES[theme_name]["dark"]
            mode_indicator = "●" if is_dark else "○"
            display = f"  {mode_indicator} {theme_name}"

            # Add current theme marker
            if theme_name == current_theme:
                display += " ←"

            # Highlight selected item
            if idx == current_idx:
                stdscr.attron(curses.color_pair(1))
                stdscr.addstr(y, 2, display.ljust(width - 4))
                stdscr.attroff(curses.color_pair(1))
            else:
                stdscr.addstr(y, 2, display)
                if theme_name == current_theme:
                    # Highlight the marker
                    marker_pos = 2 + len(display) - 2
                    stdscr.addstr(y, marker_pos, "←", curses.color_pair(2))

        # Slack theme box, only when Slack is installed and the box fits
        selected_theme = THEME_ORDER[current_idx]
        slack_theme = THEMES[selected_theme].get("slack", "")
        box_y = height - 6
        box_width = len(slack_theme) + 4
        box_x = (width - box_width) // 2

        if show_slack and box_width <= width:
            stdscr.addstr(box_y, box_x, "┌" + "─" * (box_width - 2) + "┐")
            stdscr.addstr(box_y + 1, box_x, "│ Slack theme:" + " " * (box_width - 15) + "│")
            stdscr.addstr(box_y + 2, box_x, "│ " + slack_theme + " │", curses.A_BOLD)
            stdscr.addstr(box_y + 3, box_x, "└" + "─" * (box_width - 2) + "┘")

        # Status message
        if status_message:
            stdscr.addstr(height - 2, 2, status_message, curses.color_pair(3))

        stdscr.refresh()

        # Handle input
        key = stdscr.getch()

        if key == ord("q") or key == 27:  # q or ESC
            break
        elif key == curses.KEY_UP or key == ord("k"):
            current_idx = max(0, current_idx - 1)
            status_message = ""
        elif key == curses.KEY_DOWN or key == ord("j"):
            current_idx = min(len(THEME_ORDER) - 1, current_idx + 1)
            status_message = ""
        elif key == ord("\n") or key == curses.KEY_ENTER:
            selected_theme = THEME_ORDER[current_idx]
            updated = apply_theme(selected_theme)
            if updated:
                current_theme = selected_theme
                status_message = f"Applied {selected_theme}: {', '.join(updated)}"
            else:
                status_message = f"No files updated for {selected_theme}"


if __name__ == "__main__":
    curses.wrapper(main)
