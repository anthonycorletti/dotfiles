vim.g.mapleader = ";"

local keymap = vim.keymap
local find_replace = require("find-replace")
find_replace.setup()

-- Navigate vim panes better
keymap.set("n", "<c-k>", ":wincmd k<CR>")
keymap.set("n", "<c-j>", ":wincmd j<CR>")
keymap.set("n", "<c-h>", ":wincmd h<CR>")
keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Clear search highlights
keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Move the current line or selected lines up/down (works on both platforms)
keymap.set("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
keymap.set("i", "<A-Up>", "<Esc>:m .-2<CR>==", { noremap = true, silent = true })
keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
keymap.set("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==", { noremap = true, silent = true })
keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Alternative line movement with J/K for all platforms
keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Select all with leader key
keymap.set("v", "<leader>a", "<Esc>ggVG", { silent = true })
keymap.set("n", "<leader>a", "ggVG", { silent = true })
keymap.set("i", "<leader>a", "<Esc>ggVG", { silent = true })

-- Map <leader>r to find and replace the current search pattern
keymap.set(
  "n",
  "<leader>r",
  find_replace.find_replace,
  { noremap = true, silent = true, desc = "Find and replace current search pattern" }
)

-- Save and quit mappings
keymap.set("n", "<leader>w", ":w<CR>", { silent = true, desc = "Save file" })
keymap.set("n", "<leader>q", ":q<CR>", { silent = true, desc = "Quit" })
keymap.set("n", "<leader>x", ":x<CR>", { silent = true, desc = "Save and quit" })

-- Window navigation
keymap.set("n", "<C-w>v", ":vsplit<CR>", { desc = "Split vertically" })
keymap.set("n", "<C-w>s", ":split<CR>", { desc = "Split horizontally" })

-- Buffers
keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true })
keymap.set("n", "<leader>bd", ":bdelete<CR>", { silent = true })

-- If on Mac, also include the Command key mappings for convenience
if vim.fn.has("mac") == 1 then
  -- Undo/Redo
  keymap.set("n", "<D-z>", ":undo<CR>", { noremap = true, silent = true })
  keymap.set("i", "<D-z>", "<Esc>:undo<CR>a", { noremap = true, silent = true })
  keymap.set("v", "<D-z>", "<Esc>:undo<CR>", { noremap = true, silent = true })
  keymap.set("n", "<D-Z>", ":redo<CR>", { noremap = true, silent = true })
  keymap.set("i", "<D-Z>", "<Esc>:redo<CR>a", { noremap = true, silent = true })
  keymap.set("v", "<D-Z>", "<Esc>:redo<CR>", { noremap = true, silent = true })

  -- Save
  keymap.set("n", "<D-s>", ":w<CR>", { silent = true })
  keymap.set("i", "<D-s>", "<Esc>:w<CR>a", { silent = true })
  keymap.set("v", "<D-s>", "<Esc>:w<CR>gv", { silent = true })

  -- Select all
  keymap.set("n", "<D-A>", "ggVG", { silent = true })
  keymap.set("i", "<D-A>", "<Esc>ggVG", { silent = true })
  keymap.set("v", "<D-A>", "<Esc>ggVG", { silent = true })
end
