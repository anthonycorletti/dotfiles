return {
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_filetypes = { markdown = false }
    end,
  }
}
