return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
    root_makrers = {
        ".git",
    },
    settings = {
        {
            redhat = {
                format = {
                    enabled = false,
                },
                telemetry = {
                    enabled = false,
                },
            },
        },
    },
}
