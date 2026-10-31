return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      local C = require("catppuccin.palettes").get_palette("mocha")

      require("catppuccin").setup({
        flavour = "mocha",
        auto_integrations = true,
        integrations = {
          bufferline = true,
          noice = true,
          snacks = true,
          which_key = true,
          -- lualine = {
          --   normal = {
          --     a = { bg = C.blue, fg = C.mantle, gui = "bold" },
          --     b = { bg = C.surface0, fg = C.blue },
          --     c = { bg = C.mantle, fg = C.text },
          --   },
          --
          --   insert = {
          --     a = { bg = C.green, fg = C.base, gui = "bold" },
          --     b = { bg = C.surface0, fg = C.green },
          --   },
          --
          --   terminal = {
          --     a = { bg = C.green, fg = C.base, gui = "bold" },
          --     b = { bg = C.surface0, fg = C.green },
          --   },
          --
          --   command = {
          --     a = { bg = C.peach, fg = C.base, gui = "bold" },
          --     b = { bg = C.surface0, fg = C.peach },
          --   },
          --   visual = {
          --     a = { bg = C.mauve, fg = C.base, gui = "bold" },
          --     b = { bg = C.surface0, fg = C.mauve },
          --   },
          --   replace = {
          --     a = { bg = C.red, fg = C.base, gui = "bold" },
          --     b = { bg = C.surface0, fg = C.red },
          --   },
          --   inactive = {
          --     a = { bg = C.mantle, fg = C.blue },
          --     b = { bg = C.mantle, fg = C.surface1, gui = "bold" },
          --     c = { bg = C.mantle, fg = C.overlay0 },
          --   },
          -- },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
