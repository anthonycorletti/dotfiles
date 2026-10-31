return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "catppuccin-nvim" },
      sections = {
        lualine_c = { { "filename", path = 2, shorting_target = 0 } },
        lualine_x = { "encoding", "filetype" },
      },
      inactive_sections = {
        lualine_c = { { "filename", path = 2, shorting_target = 0 } },
      },
    },
  },
}
