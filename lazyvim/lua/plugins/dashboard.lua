return {
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      opts.config.center = {
        { action = 'lua LazyVim.pick()()',                           desc = " Find File",       icon = " ", key = "f" },
        { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
        { action = 'lua LazyVim.pick("oldfiles")()',                 desc = " Recent Files",    icon = " ", key = "r" },
        { action = 'lua LazyVim.pick("live_grep")()',                desc = " Find Text",       icon = " ", key = "g" },
        { action = 'lua LazyVim.pick.config_files()()',              desc = " Config",          icon = " ", key = "c" },
        { action = "Telescop project",                               desc = " Find project",    icon = " ", key = "p" },
        { action = 'lua require("persistence").load({last = true})', desc = " Restore Session", icon = " ", key = "s" },
        { action = "LazyExtras",                                     desc = " Lazy Extras",     icon = " ", key = "x" },
        { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
        { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end
    end,
  },
}
