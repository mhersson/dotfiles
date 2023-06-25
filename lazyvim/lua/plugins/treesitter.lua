return {
  --
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "comment",
        "html",
        "dockerfile",
        "go",
        "gomod",
        "gowork",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "rust",
        "toml",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
}
