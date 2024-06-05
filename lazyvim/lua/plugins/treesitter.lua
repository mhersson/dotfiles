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
        "gosum",
        "gotmpl",
        "gowork",
        "hyprlang",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "nix",
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
