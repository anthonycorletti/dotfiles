return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.opt.termguicolors = true

      local ok, ghostty = pcall(require, "custom.ghostty_colors")
      local c = (ok and ghostty.palette) or {}

      require("bufferline").setup({
        options = {
          mode = "buffers",
        },
        highlights = {
          fill = { bg = c.bg },
          background = { bg = c.bg, fg = c.br_black },

          buffer_visible = { bg = c.bg, fg = c.fg },
          buffer_selected = { bg = c.bg, fg = c.fg, bold = true },

          duplicate = { bg = c.bg, fg = c.br_black },
          duplicate_visible = { bg = c.bg, fg = c.fg },
          duplicate_selected = { bg = c.bg, fg = c.fg, bold = true },

          close_button = { bg = c.bg, fg = c.br_black },
          close_button_visible = { bg = c.bg, fg = c.br_black },
          close_button_selected = { bg = c.bg, fg = c.fg },

          modified = { bg = c.bg, fg = c.green },
          modified_visible = { bg = c.bg, fg = c.green },
          modified_selected = { bg = c.bg, fg = c.green },

          separator = { bg = c.bg, fg = c.bg },
          separator_visible = { bg = c.bg, fg = c.bg },
          separator_selected = { bg = c.bg, fg = c.bg },

          indicator_selected = { bg = c.bg, fg = c.yellow },
        },
      })
    end,
  },
}
