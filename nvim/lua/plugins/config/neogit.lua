local status_ok, neogit = pcall(require, "neogit")
if not status_ok then return end

neogit.setup({
  disable_commit_confirmation = true,
  use_magit_keybindings = false,
  integrations = {
    diffview = false
  },
})
