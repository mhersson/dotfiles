return {
  -- change some telescope options
  {
    "nvim-telescope/telescope.nvim",
    -- change some options
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        mappings = {
          i = {
            ["<esc>"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-file-browser.nvim",
      },
      {
        "nvim-telescope/telescope-project.nvim",
        keys = {
          { "<leader>fp", "<cmd>lua require'telescope'.extensions.project.project{}<cr>", desc = "Telescope Project" },
        },
      },
    },
    opts = {
      extensions = {
        project = {
          base_dirs = {
            { path = "~/Development/" },
            { path = "~/Documents/" },
            { path = "~/.dotfiles/" },
          },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("project")
      telescope.load_extension("file_browser")
    end,
  },
}
