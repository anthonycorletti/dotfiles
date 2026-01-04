local web_fmt = { "prettierd", "prettier", stop_after_first = true }

return {
  { "numToStr/Comment.nvim", opts = {} },

  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

  { "folke/todo-comments.nvim", event = "VimEnter", dependencies = "nvim-lua/plenary.nvim", opts = { signs = false } },

  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.surround").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      indent = { enable = true },
      highlight = { enable = true },
    },
  },

  {
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        return { timeout_ms = 2500, lsp_format = "true" }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "ruff_organize_imports" },
        ruby = { "standardrb" },
        go = { "gofmt" },
        typescript = web_fmt,
        javascript = web_fmt,
        typescriptreact = web_fmt,
        javascriptreact = web_fmt,
        json = web_fmt,
        html = web_fmt,
        css = web_fmt,
        scss = web_fmt,
        yaml = web_fmt,
        markdown = web_fmt,
      },
    },
  },

  { "RRethy/vim-illuminate" },

  {
    "github/copilot.vim",
    config = function()
      vim.b.copilot_enabled = true
      vim.g.copilot_filetypes = { markdown = false }
    end,
  },
}
