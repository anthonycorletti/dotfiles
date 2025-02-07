vim.g.mapleader = ";"

-- Set clipboard registers (optional shortcut for '+y')
vim.keymap.set("n", "<C-c>", '"+y') -- Cmd+C to copy in normal mode
vim.keymap.set("v", "<C-c>", '"+y') -- Cmd+C to copy in visual mode

-- Move the current line or selected lines up
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })

-- Move the current line or selected lines down
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Clear search highlights
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
