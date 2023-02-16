local status_ok, notify = pcall(require, "notify")
if not status_ok then return end

notify.setup({
  stages = "fade",
  background_colour = '#000000',
  timeout = 5000,
})
