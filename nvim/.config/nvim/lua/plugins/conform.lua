local web_fmt = { "prettierd", "prettier", stop_after_first = true }

return {
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
        return { timeout_ms = 2500, lsp_format = "fallback" }
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
  }
}
