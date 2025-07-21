local api = vim.api
local clear_registers = require("clear-registers")

-- Automatically save when leaving a buffer
api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function()
    api.nvim_command("silent! w")
  end,
})

api.nvim_create_user_command("ClearReg", clear_registers.clear_registers, { desc = "Clear all registers" })
