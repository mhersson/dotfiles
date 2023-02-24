return {
  "echasnovski/mini.bufremove",
  keys = {
    {
      "<leader>bk",
      function()
        require("mini.bufremove").delete(0, false)
      end,
      desc = "Kill Buffer",
    },
  },
}
