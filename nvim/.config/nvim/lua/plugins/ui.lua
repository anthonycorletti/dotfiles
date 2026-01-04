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
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
      },
      messages = {
        enabled = true,
      },
      popupmenu = {
        enabled = false,
      },
      notify = {
        enabled = false,
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = { enabled = true },
    },
  },


  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local ghostty = require("custom.ghostty")
      local c = ghostty.palette

      local custom_theme = {
        normal = {
          a = { bg = c.blue, fg = c.bg, gui = "bold" },
          b = { bg = c.br_black, fg = c.fg },
          c = { bg = c.bg, fg = c.fg },
        },
        insert = {
          a = { bg = c.green, fg = c.bg, gui = "bold" },
          b = { bg = c.br_black, fg = c.fg },
        },
        visual = {
          a = { bg = c.magenta, fg = c.bg, gui = "bold" },
          b = { bg = c.br_black, fg = c.fg },
        },
        replace = {
          a = { bg = c.red, fg = c.bg, gui = "bold" },
          b = { bg = c.br_black, fg = c.fg },
        },
        command = {
          a = { bg = c.yellow, fg = c.bg, gui = "bold" },
          b = { bg = c.br_black, fg = c.fg },
        },
        inactive = {
          a = { bg = c.bg, fg = c.br_black },
          b = { bg = c.bg, fg = c.br_black },
          c = { bg = c.bg, fg = c.br_black },
        },
      }

      require("lualine").setup({
        options = {
          theme = custom_theme,
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
    end,
  },
}
