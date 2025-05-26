return {
  {
    dir = vim.fn.stdpath("config") .. "/lua",
    name = "ghostty",
    lazy = false,
    priority = 1000,
    config = function()
      require("ghostty-theme").set()
    end,
  },
}
