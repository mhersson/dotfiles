return {
    cmd = {
        "mpls",
        "--dark-mode",
        "--enable-emoji",
        "--enable-footnotes",
        "--plantuml-server",
        "localhost:8080",
        "--plantuml-path",
        "/",
        "--plantuml-disable-tls",
    },
    root_markers = { ".marksman.toml", ".git" },
    filetypes = { "markdown", "makdown.mdx" },
}
