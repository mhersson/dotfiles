return {
    cmd = { "golangci-lint-langserver" },
    root_markers = {
        ".golangci.yml",
        ".golangci.yaml",
        ".golangci.toml",
        ".golangci.json",
        "go.work",
        "go.mod",
        ".git",
    },
    filetypes = { "go", "gomod" },
    init_options = {
        command = {
            "golangci-lint",
            "run",
            "--output.json.path",
            "stdout",
            "--show-stats=false",
            "--output.text.path=",
            "--tests",
        },
    },
}
