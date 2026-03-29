#!/usr/bin/env python3
"""
Chameleon - Theme Switcher for dotfiles

A TUI application to switch color themes across multiple applications.
Uses curses for the interface, no external dependencies required.
"""

import curses
import json
import re
import subprocess
from pathlib import Path

# Detect dotfiles directory from script location
DOTFILES_DIR = Path(__file__).parent.resolve()

# Theme definitions with per-app values
# Each theme has: dark (bool), and app-specific values
THEMES = {
    "catppuccin-mocha": {
        "dark": True,
        "nvim": "catppuccin",
        "nvim_flavor": "mocha",
        "helix": "catppuccin_mocha",
        "wezterm": "Catppuccin Mocha",
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
        "k9s": "everforest-dark",
        "bat": "Everforest Dark",
        "zed_dark": "Everforest Dark Medium",
        "zed_light": "Everforest Light Medium",
        "mpls": "everforest-dark",
        "yclock": {"bg": "#272e33", "fg": "#d2c6aa", "accent": "#ed8796"},
        "slack": "#272E33,#343F44,#7FBBB3,#272E33,#3D484D,#D3C6AA,#A7C080,#E67E80",
    },
    "tokyonight": {
        "dark": True,
        "nvim": "tokyonight",
        "nvim_style": "night",
        "helix": "tokyonight",
        "wezterm": "Tokyo Night",
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
    "catppuccin-mocha",
    "catppuccin-macchiato",
    "catppuccin-frappe",
    "catppuccin-latte",
    "gruvbox-light",
    "everforest-dark",
    "tokyonight",
    "tokyonight-storm",
    "tokyonight-moon",
]


def update_file_with_regex(filepath: Path, pattern: str, replacement: str) -> bool:
    """Update a file by replacing a regex pattern with a replacement string."""
    if not filepath.exists():
        return False
    content = filepath.read_text()
    new_content, count = re.subn(pattern, replacement, content, count=1)
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


def update_k9s(theme: dict) -> bool:
    """Update K9s config.yaml skin."""
    filepath = DOTFILES_DIR / "k9s" / "config.yaml"
    return update_file_with_regex(filepath, r"skin: .*", f"skin: {theme['k9s']}")


def update_bat(theme: dict) -> bool:
    """Update Fish config.fish BAT_THEME."""
    filepath = DOTFILES_DIR / "fish" / "config.fish"
    return update_file_with_regex(
        filepath,
        r'set -gx BAT_THEME ".*"',
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
        content = re.sub(pattern, rf'\1"{theme["zed_dark"]}"', content)

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


def set_macos_appearance(dark: bool) -> bool:
    """Set macOS system appearance using osascript."""
    appearance = "true" if dark else "false"
    script = f'tell app "System Events" to tell appearance preferences to set dark mode to {appearance}'
    try:
        subprocess.run(["osascript", "-e", script], check=True, capture_output=True)
        return True
    except subprocess.CalledProcessError:
        return False


def detect_current_theme() -> str | None:
    """Detect the currently active theme by reading config files."""
    # Check Neovim config for ACTIVE_THEME
    nvim_path = DOTFILES_DIR / "nvim" / "lua" / "plugins" / "colorscheme.lua"
    if nvim_path.exists():
        content = nvim_path.read_text()
        match = re.search(r'^local ACTIVE_THEME = "([^"]*)"', content, re.MULTILINE)
        if match:
            nvim_theme = match.group(1)

            # For catppuccin, also check flavor
            if nvim_theme == "catppuccin":
                flavor_match = re.search(r'flavor = "([^"]*)"', content)
                if flavor_match:
                    flavor = flavor_match.group(1)
                    return f"catppuccin-{flavor}"

            # For tokyonight, check style
            if nvim_theme == "tokyonight":
                style_match = re.search(r'style = "([^"]*)"', content)
                if style_match:
                    style = style_match.group(1)
                    if style == "night":
                        return "tokyonight"
                    return f"tokyonight-{style}"

            # Map other nvim themes to our theme names
            nvim_to_theme = {
                "everforest": "everforest-dark",
                "gruvbox": "gruvbox-light",
            }
            return nvim_to_theme.get(nvim_theme, nvim_theme)

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
    if set_macos_appearance(theme["dark"]):
        updated.append("macOS")

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

        # Theme list
        start_y = 5
        for idx, theme_name in enumerate(THEME_ORDER):
            y = start_y + idx
            if y >= height - 8:  # Leave room for Slack box
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

        # Slack theme box
        selected_theme = THEME_ORDER[current_idx]
        slack_theme = THEMES[selected_theme].get("slack", "")
        box_y = height - 6
        box_width = len(slack_theme) + 4
        box_x = (width - box_width) // 2

        # Draw box
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
