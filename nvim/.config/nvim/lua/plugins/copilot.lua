return {
  "github/copilot.vim",
  config = function()
    vim.b.copilot_enabled = true
    vim.g.copilot_filetypes = {
      markdown = false,
    }
  end,
}
