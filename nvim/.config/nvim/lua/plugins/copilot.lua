return {
  "github/copilot.vim",
  config = function()
    vim.b.copilot_enabled = false
    vim.g.copilot_filetypes = {
      markdown = false,
    }
  end,
}
