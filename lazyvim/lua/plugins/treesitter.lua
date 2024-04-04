return {
  --
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "cue",
        "comment",
        "html",
        "dockerfile",
        "gitcommit",
        "go",
        "gomod",
        "gowork",
        "hyprlang",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "rust",
        "toml",
        "vim",
        "yaml",
        "zig",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
  },
}
