-------------------------------------------------------------------------------
-- General Keybindings, not plugin specific
-------------------------------------------------------------------------------
local opts = { silent = true }

-- Set the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Turn off arrow keys - force HJKL
vim.keymap.set("n", "<UP>", "<NOP>", opts)
vim.keymap.set("n", "<DOWN>", "<NOP>", opts)
vim.keymap.set("n", "<LEFT>", "<NOP>", opts)
vim.keymap.set("n", "<RIGHT>", "<NOP>", opts)

-- Map Ctrl-c to esc
vim.keymap.set("i", "<C-c>", "<esc>", opts)

-- Map jj to esc
vim.keymap.set("i", "jj", "<esc>", opts)

-- Use Del key for black hole register
vim.keymap.set("", "<Del>", '"_x', opts)

-- Enable press and hold for deleting same as Del
vim.keymap.set("n", "x", '"_x', opts)

-- Paste over selected text
vim.keymap.set("v", "p", '"_dP', opts)

-- Better Indentation
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Insert lines above/below without leaving normal mode
vim.keymap.set("n", "oo", "o<Esc>k", opts)
vim.keymap.set("n", "OO", "O<Esc>j", opts)

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

-- Navigate quicklist items
vim.keymap.set("n", "gn", "<cmd>cnext<cr>")
vim.keymap.set("n", "gp", "<cmd>cprev<cr>")


-------------------------------------------------------------------------------
-- Buffers
-------------------------------------------------------------------------------
-- Delete buffer
-- vim.keymap.set("n", "<c-w>", ":bd<CR>", opts)
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)

-------------------------------------------------------------------------------
-- Splits
-------------------------------------------------------------------------------
-- Resize splits with alt+cursor keys
vim.keymap.set("n", "<M-Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<M-Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<M-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<M-Right>", ":vertical resize +2<CR>", opts)
