return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sections = {
        lualine_c = { { "filename", path = 2, shorting_target = 0 } },
        lualine_x = { "encoding", "filetype" },
      },
      inactive_sections = {
        lualine_c = { { "filename", path = 2, shorting_target = 0 } },
      },
      options = {
        theme = "catppuccin-nvim",
      },
    },
  },
}
