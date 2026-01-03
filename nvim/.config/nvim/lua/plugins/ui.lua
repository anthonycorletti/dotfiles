return {
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      },
    },
  },

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup({
        options = {
          mode = "buffers",
        },
      })
    end,
  },

  {
    dir = vim.fn.stdpath("config") .. "/lua",
    name = "ghostty",
    lazy = false,
    priority = 1000,
    config = function()
      local ghostty = require("custom.ghostty")
      ghostty.set()
      ghostty.setup_auto_reload()
    end,
  },
}
