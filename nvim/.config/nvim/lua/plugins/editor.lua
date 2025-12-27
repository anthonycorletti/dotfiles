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
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.have_nerd_font })
      statusline.section_location = function() return "%2l:%-2v" end
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({ auto_install = true })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldenable = false
        end,
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
      { "<leader>f", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, mode = "", desc = "Format buffer" },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        if vim.tbl_contains({ "c", "cpp" }, vim.bo[bufnr].filetype) then return nil end
        return { timeout_ms = 2500, lsp_format = "true" }
      end,
      formatters_by_ft = {
        lua = { "stylua" }, python = { "ruff_format", "ruff_organize_imports" },
        ruby = { "standardrb" }, go = { "gofmt" },
        typescript = web_fmt, javascript = web_fmt, typescriptreact = web_fmt, javascriptreact = web_fmt,
        json = web_fmt, html = web_fmt, css = web_fmt, scss = web_fmt, yaml = web_fmt, markdown = web_fmt,
      },
    },
  },

  { "github/copilot.vim", config = function()
    vim.b.copilot_enabled = true
    vim.g.copilot_filetypes = { markdown = false }
  end },
}
