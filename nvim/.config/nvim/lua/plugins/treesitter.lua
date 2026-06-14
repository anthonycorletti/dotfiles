return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      indent = { enable = true },
      highlight = { enable = true },
    },
  }
}

