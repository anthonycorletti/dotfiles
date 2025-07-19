local opt = vim.opt

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true         -- shows absolute line number on cursor line (when relative number is on)

-- searching
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- ignore case if search pattern is all lowercase

-- cursor
opt.cursorline = true -- highlight the current line

-- colors
opt.termguicolors = true -- enable 24-bit RGB colors

-- backspace
opt.backspace = "indent,eol,start" -- allow backspacing over everything in insert mode

-- clipboard
opt.clipboard = "unnamedplus"

-- split windows
opt.splitbelow = true -- split windows below current window
opt.splitright = true -- split windows to the right of the current window

-- no swapfiles
opt.swapfile = false

-- characters
opt.list = true
opt.fillchars = { eob = " " }

-- Preview substitutions live, as you type!
opt.inccommand = "split"
