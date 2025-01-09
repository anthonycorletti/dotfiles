vim.g.mapleader = " "
vim.g.editorconfig = true
vim.wo.number = true

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Clear search highlights
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Spell check
vim.opt.spell = true
vim.opt.spelllang = 'en_us'

vim.cmd("syntax enable")
