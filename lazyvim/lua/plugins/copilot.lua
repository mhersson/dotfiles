return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    opts = {
      auth_provider_url = "https://dnb.ghe.com",
    },
    keys = {
      {
        "<leader>at",
        function()
          if require("copilot.client").is_disabled() then
            require("copilot.command").enable()
          else
            require("copilot.command").disable()
          end
        end,
        desc = "Toggle (Copilot)",
      },
    },
  },
}
