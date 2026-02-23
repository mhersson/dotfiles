# Retrieve the theme settings
export def main [] {
    return {
        separator: "#9DA9A0"
        leading_trailing_space_bg: { attr: "n" }
        header: { fg: "#A7C080" attr: "b" }
        empty: "#7FBBB3"
        bool: {|| if $in { "#83C092" } else { "light_gray" } }
        int: "#9DA9A0"
        filesize: {|e|
            if $e == 0b {
                "#9DA9A0"
            } else if $e < 1mb {
                "#83C092"
            } else {{ fg: "#7FBBB3" }}
        }
        duration: "#9DA9A0"
        datetime: {|| (date now) - $in |
            if $in < 1hr {
                { fg: "#E67E80" attr: "b" }
            } else if $in < 6hr {
                "#E67E80"
            } else if $in < 1day {
                "#DBBC7F"
            } else if $in < 3day {
                "#A7C080"
            } else if $in < 1wk {
                { fg: "#A7C080" attr: "b" }
            } else if $in < 6wk {
                "#83C092"
            } else if $in < 52wk {
                "#7FBBB3"
            } else { "dark_gray" }
        }
        range: "#9DA9A0"
        float: "#9DA9A0"
        string: "#9DA9A0"
        nothing: "#9DA9A0"
        binary: "#9DA9A0"
        cell-path: "#9DA9A0"
        row_index: { fg: "#A7C080" attr: "b" }
        record: "#9DA9A0"
        list: "#9DA9A0"
        block: "#9DA9A0"
        hints: "dark_gray"
        search_result: { fg: "#E67E80" bg: "#9DA9A0" }

        shape_and: { fg: "#D699B6" attr: "b" }
        shape_binary: { fg: "#D699B6" attr: "b" }
        shape_block: { fg: "#7FBBB3" attr: "b" }
        shape_bool: "#83C092"
        shape_custom: "#A7C080"
        shape_datetime: { fg: "#83C092" attr: "b" }
        shape_directory: "#83C092"
        shape_external: "#83C092"
        shape_externalarg: { fg: "#A7C080" attr: "b" }
        shape_filepath: "#83C092"
        shape_flag: { fg: "#7FBBB3" attr: "b" }
        shape_float: { fg: "#D699B6" attr: "b" }
        shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: "b" }
        shape_globpattern: { fg: "#83C092" attr: "b" }
        shape_int: { fg: "#D699B6" attr: "b" }
        shape_internalcall: { fg: "#83C092" attr: "b" }
        shape_list: { fg: "#83C092" attr: "b" }
        shape_literal: "#7FBBB3"
        shape_match_pattern: "#A7C080"
        shape_matching_brackets: { attr: "u" }
        shape_nothing: "#83C092"
        shape_operator: "#DBBC7F"
        shape_or: { fg: "#D699B6" attr: "b" }
        shape_pipe: { fg: "#D699B6" attr: "b" }
        shape_range: { fg: "#DBBC7F" attr: "b" }
        shape_record: { fg: "#83C092" attr: "b" }
        shape_redirection: { fg: "#D699B6" attr: "b" }
        shape_signature: { fg: "#A7C080" attr: "b" }
        shape_string: "#A7C080"
        shape_string_interpolation: { fg: "#83C092" attr: "b" }
        shape_table: { fg: "#7FBBB3" attr: "b" }
        shape_variable: "#D699B6"

        background: "#2D353B"
        foreground: "#D3C6AA"
        cursor: "#D3C6AA"
    }
}

# Update the Nushell configuration
export def --env "set color_config" [] {
    $env.config.color_config = (main)
}

# Update terminal colors
export def "update terminal" [] {
    let theme = (main)

    # Set terminal colors
    let osc_screen_foreground_color = '10;'
    let osc_screen_background_color = '11;'
    let osc_cursor_color = '12;'

    $"
    (ansi -o $osc_screen_foreground_color)($theme.foreground)(char bel)
    (ansi -o $osc_screen_background_color)($theme.background)(char bel)
    (ansi -o $osc_cursor_color)($theme.cursor)(char bel)
    "
    # Line breaks above are just for source readability
    # but create extra whitespace when activating. Collapse
    # to one line and print with no-newline
    | str replace --all "\n" ''
    | print -n $"($in)\r"
}

export module activate {
    export-env {
        set color_config
        update terminal
    }
}

# Activate the theme when sourced
use activate
