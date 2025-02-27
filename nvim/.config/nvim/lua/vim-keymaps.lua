vim.g.mapleader = ";"

local keymap = vim.keymap

-- Navigate vim panes better
keymap.set("n", "<c-k>", ":wincmd k<CR>")
keymap.set("n", "<c-j>", ":wincmd j<CR>")
keymap.set("n", "<c-h>", ":wincmd h<CR>")
keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Clear search highlights
keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Move the current line or selected lines up
keymap.set("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
keymap.set("i", "<A-Up>", "<Esc>:m .-2<CR>==", { noremap = true, silent = true })
keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Move the current line or selected lines down
keymap.set("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==", { noremap = true, silent = true })
keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Map D-z and D-Z to undo and redo
keymap.set("n", "<D-z>", ":undo<CR>", { noremap = true, silent = true })
keymap.set("n", "<D-Z>", ":redo<CR>", { noremap = true, silent = true })
keymap.set("i", "<D-z>", "<Esc>:undo<CR>a", { noremap = true, silent = true })
keymap.set("i", "<D-Z>", "<Esc>:redo<CR>a", { noremap = true, silent = true })

-- Map D-s to save in normal and insert mode
keymap.set("n", "<D-s>", ":w<CR>", { silent = true })
keymap.set("i", "<D-s>", "<Esc>:w<CR>a", { silent = true })

-- Map C-a to select all in the current buffer
keymap.set("n", "<D-A>", "ggVG")
keymap.set("i", "<D-A>", "<Esc>ggVG")
keymap.set("v", "<D-A>", "<Esc>ggVG")

-- Map D-f to search forward in normal and insert mode
keymap.set("n", "<D-f>", ":%s/<C-r><C-w>//g<Left><Left>", { noremap = true })
keymap.set("i", "<D-f>", "<Esc>:%s/<C-r><C-w>//g<Left><Left>", { noremap = true })
keymap.set("v", "<D-f>", ":%s/<C-r><C-w>//g<Left><Left>", { noremap = true })
