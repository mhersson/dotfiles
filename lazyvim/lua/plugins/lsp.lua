return {
  {
    "neovim/nvim-lspconfig",
    codelens = {
      enabled = true,
    },
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        cuepls = {},
        yamlls = {
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas({
                extra = {
                  {
                    description = "Mario generator API v3 schema",
                    fileMatch = "generator.yaml",
                    name = "Mario generator.yaml",
                    url = "https://mario-infra.release.rnd.cue.cloud/schema/generator-schema.json",
                  },
                  {
                    description = "Mario component schema",
                    fileMatch = "components/*.yaml",
                    name = "Mario components",
                    url = "https://mario-infra.release.rnd.cue.cloud/schema/component-schema.json",
                  },
                },
              })
            )
          end,
          settings = {
            yaml = {
              -- disable formatting because it's handled by yamlfmt
              format = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
}
