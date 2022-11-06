local status_ok, neotest = pcall(require, "neotest")
if not status_ok then return end

neotest.setup({
  adapters = {
    require("neotest-go")({
      experimental = {
        test_table = true,
      },
    }),
  },
  icons = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    failed = "✖",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",
    passed = "✔",
    running = "~",
    skipped = "ﰸ",
    unknown = "?"
  },
  consumers = {
    always_open_output = function(client)
      local async = require("neotest.async")

      client.listeners.results = function(adapter_id, results)
        local file_path = async.fn.expand("%:p")
        local row = async.fn.getpos(".")[2] - 1
        local position = client:get_nearest(file_path, row, {})
        if not position then
          return
        end
        local pos_id = position:data().id
        if not results[pos_id] then
          return
        end
        neotest.output.open({ position_id = pos_id, adapter = adapter_id })
      end
    end,
  },
})
