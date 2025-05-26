return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local c = require("ghostty-theme").palette

    local ghostty_theme = {
      normal = {
        a = { fg = c.bg, bg = c.blue, gui = "bold" },
        b = { fg = c.white, bg = c.br_black },
        c = { fg = c.fg, bg = c.bg },
      },
      insert = {
        a = { fg = c.bg, bg = c.green, gui = "bold" },
        b = { fg = c.white, bg = c.br_black },
        c = { fg = c.fg, bg = c.bg },
      },
      visual = {
        a = { fg = c.bg, bg = c.magenta, gui = "bold" },
        b = { fg = c.white, bg = c.br_black },
        c = { fg = c.fg, bg = c.bg },
      },
      replace = {
        a = { fg = c.bg, bg = c.red, gui = "bold" },
        b = { fg = c.white, bg = c.br_black },
        c = { fg = c.fg, bg = c.bg },
      },
      command = {
        a = { fg = c.bg, bg = c.yellow, gui = "bold" },
        b = { fg = c.white, bg = c.br_black },
        c = { fg = c.fg, bg = c.bg },
      },
      inactive = {
        a = { fg = c.fg, bg = c.bg },
        b = { fg = c.fg, bg = c.bg },
        c = { fg = c.fg, bg = c.bg },
      },
    }

    require("lualine").setup({
      options = {
        theme = ghostty_theme,
      },
    })
  end,
}
