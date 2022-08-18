local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then return end

toggleterm.setup({
  open_mapping = [[<c-\>]],
  direction = "float",
})

local Terminal = require("toggleterm.terminal").Terminal

local defaults = {
  direction = "float",
  float_opts = {
    border = "single",
  },
}

local htop = Terminal:new(vim.tbl_deep_extend("force", {
  cmd = "htop",
}, defaults))

function Toggle_htop()
  htop:toggle()
end

local lazygit = Terminal:new(vim.tbl_deep_extend("force", {
  cmd = "lazygit",
  dir = "git_dir",
  hidden = true,
}, defaults))

function Toggle_lazygit()
  lazygit:toggle()
end

local ranger = Terminal:new(vim.tbl_deep_extend("force", {
  cmd = "ranger",
}, defaults))


function Toggle_ranger()
  ranger:toggle()
end
