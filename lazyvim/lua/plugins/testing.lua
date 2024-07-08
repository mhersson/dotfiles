return {
  {
    "fredrikaverpil/neotest-golang",
    enabled = false,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      for k, v in pairs(opts.adapters) do
        if k == "neotest-golang" then
          opts.adapters[k] = nil
          break
        end
      end
      opts.adapters["neotest-go"] = {
        args = { "-tags=integration" },
      }
    end,
  },
}
