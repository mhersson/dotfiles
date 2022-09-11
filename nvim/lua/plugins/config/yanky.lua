local status_ok, yanky = pcall(require, "yanky")
if not status_ok then return end

yanky.setup()

local opts = { silent = true }

vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", opts)
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", opts)
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", opts)
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", opts)
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)", opts)
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)", opts)
