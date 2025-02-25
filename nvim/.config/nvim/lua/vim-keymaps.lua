vim.g.mapleader = ";"

local keymap = vim.keymap

-- Navigate vim panes better
keymap.set("n", "<c-k>", ":wincmd k<CR>")
keymap.set("n", "<c-j>", ":wincmd j<CR>")
keymap.set("n", "<c-h>", ":wincmd h<CR>")
keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Clear search highlights
keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Map D-z and D-Z to undo and redo
keymap.set("n", "<D-z>", ":undo<CR>")
keymap.set("n", "<D-Z>", ":redo<CR>")
keymap.set("i", "<D-z>", "<ESC>:undo<CR>a")
keymap.set("i", "<D-Z>", "<ESC>:redo<CR>a")

-- Map D-s to save in normal and insert mode
keymap.set("n", "<D-s>", ":w<CR>")
keymap.set("i", "<D-s>", "<ESC>:w<CR>a")

-- Map C-a to select all in the current buffer
keymap.set("n", "<D-A>", "ggVG")
