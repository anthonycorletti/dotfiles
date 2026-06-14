return {
  {
    dir = vim.fn.stdpath("config") .. "/lua",
    name = "ghostty_colors",
    lazy = false,
    priority = 1000,
    config = function()
      local ghostty_colors = require("custom.ghostty_colors")
      ghostty_colors.set()
    end,
  }
}
