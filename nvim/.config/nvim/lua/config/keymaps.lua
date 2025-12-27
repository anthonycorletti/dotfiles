local map = vim.keymap.set
local api = vim.api

-- General
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>a", "ggVG", { silent = true, desc = "Select all" })

-- Window navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Focus left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Focus right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Focus upper window" })
map("n", "<C-w>v", ":vsplit<CR>", { desc = "Split vertically" })
map("n", "<C-w>s", ":split<CR>", { desc = "Split horizontally" })

-- Move lines
map("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==", { noremap = true, silent = true })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
map("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
map("i", "<A-Down>", "<Esc>:m .+1<CR>==", { noremap = true, silent = true })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Bufferline
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })
map("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { desc = "Pick buffer to close" })
map("n", "<leader><left>", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
map("n", "<leader><right>", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })

for i = 1, 9 do
  map("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Go to buffer " .. i })
end

-- Splits with buffer picker
map("n", "<leader>sh", "<cmd>split | Telescope buffers<CR>", { desc = "Split and open buffer" })
map("n", "<leader>sv", "<cmd>vsplit | Telescope buffers<CR>", { desc = "Vsplit and open buffer" })


-- Commands for common typos
api.nvim_create_user_command("W", "w", {})
api.nvim_create_user_command("Q", "q", {})
api.nvim_create_user_command("Wq", "wq", {})
api.nvim_create_user_command("WQ", "wq", {})
api.nvim_create_user_command("Wqa", "wqa", {})
api.nvim_create_user_command("WQa", "wqa", {})
api.nvim_create_user_command("WQA", "wqa", {})
api.nvim_create_user_command("Qa", "qa", {})
api.nvim_create_user_command("QA", "qa", {})
