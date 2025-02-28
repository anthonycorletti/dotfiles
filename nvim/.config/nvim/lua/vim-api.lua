local api = vim.api
local clear_registers = require("clear-registers")

-- Automatically format on save
api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Automatically save when leaving a buffer
api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function()
    api.nvim_command("silent! w")
  end,
})

api.nvim_create_user_command("ClearReg", clear_registers.clear_registers, { desc = "Clear all registers" })
