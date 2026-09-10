return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local ok, ghostty = pcall(require, "custom.ghostty_colors")
      local c = (ok and ghostty.palette) or {}

      local mode_colors = {
        normal = c.blue,
        insert = c.green,
        visual = c.magenta,
        replace = c.red,
        command = c.yellow,
        inactive = c.br_black,
      }

      local function mode_section(color)
        return { bg = color, fg = c.bg, gui = "bold" }
      end

      local custom_theme = {
        normal = {
          a = mode_section(mode_colors.normal),
          b = { bg = c.black, fg = c.fg },
          c = { bg = c.bg, fg = c.fg },
        },
        insert = { a = mode_section(mode_colors.insert) },
        visual = { a = mode_section(mode_colors.visual) },
        replace = { a = mode_section(mode_colors.replace) },
        command = { a = mode_section(mode_colors.command) },
        inactive = {
          a = { bg = c.bg, fg = c.br_black },
          b = { bg = c.bg, fg = c.br_black },
          c = { bg = c.bg, fg = c.br_black },
        },
      }
      -- fill in b/c for the non-normal modes so lualine doesn't fall back to defaults
      for _, mode in ipairs({ "insert", "visual", "replace", "command" }) do
        custom_theme[mode].b = custom_theme.normal.b
        custom_theme[mode].c = custom_theme.normal.c
      end

      require("lualine").setup({
        options = {
          theme = custom_theme,
        },
        sections = {
          lualine_c = { { "filename", path = 2, shorting_target = 0 } },
          lualine_x = { "encoding", "filetype" },
        },
        inactive_sections = {
          lualine_c = { { "filename", path = 2, shorting_target = 0 } },
        },
      })
    end,
  },
}
