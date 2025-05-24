return {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
    root_makrers = { ".git" },
    settings = {
        bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)",
        },
    },
}
