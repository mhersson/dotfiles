return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
    root_makrers = {
        ".git",
    },
    settings = {
        {
            format = {
                enabled = false,
            },
            redhat = {
                telemetry = {
                    enabled = false,
                },
            },
        },
    },
}
