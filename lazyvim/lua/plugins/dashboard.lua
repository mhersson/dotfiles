return {
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      opts.config.center = {
        { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
        { action = "Telescop project", desc = " Find project", icon = " ", key = "p" },
        { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
        { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
        { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
        {
          action = [[lua require("lazyvim.util").telescope.config_files()()]],
          desc = " Config",
          icon = " ",
          key = "c",
        },
        {
          action = 'lua require("persistence").load({ last = true })',
          desc = " Restore Session",
          icon = " ",
          key = "s",
        },
        { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
        { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
        { action = "qa", desc = " Quit", icon = " ", key = "q" },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end
    end,
  },
}
