-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>a", "ggVG", { desc = "select all" })

vim.keymap.set("i", "<C-h>", "<Left>", { desc = "move left in insert mode" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "move down in insert mode" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "move up in insert mode" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "move right in insert mode" })
