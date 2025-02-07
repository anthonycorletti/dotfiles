-- Automatically format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Automatically save when leaving a buffer
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function()
    vim.api.nvim_command("silent! w")
  end,
})
