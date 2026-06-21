return {
  {
    "folke/persistence.nvim",
    lazy = false,
    config = function()
      require("persistence").setup({
        dir = vim.fn.stdpath("state") .. "/sessions/",
      })
    end,
  },
}
