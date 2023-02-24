-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { silent = true }

-- Easy save
vim.keymap.set("n", "<c-s>", "<NOP>", opts)
vim.keymap.set("i", "<c-s>", "<NOP>", opts)
vim.keymap.set("n", "<c-s>", "<cmd>w<cr>", opts)
vim.keymap.set("i", "<c-s>", "<esc><cmd>w<cr>", opts)

-- Easy quit
vim.keymap.set("n", "<c-q>", "<NOP>", opts)
vim.keymap.set("i", "<c-q>", "<NOP>", opts)
vim.keymap.set("n", "<c-q>", "<cmd>qa<cr>", opts)
vim.keymap.set("i", "<c-q>", "<esc><cmd>qa<cr>", opts)

-- Buffer navigation
vim.keymap.set("n", "<C-j>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<C-k>", ":bnext<CR>", opts)

-- Yanky
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", opts)
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", opts)
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", opts)
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", opts)
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)", opts)
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)", opts)
