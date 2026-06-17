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
      format_on_save = function()
        return { timeout_ms = 2500, lsp_format = "fallback" }
      end,
      formatters = {
        prettier = { command = "bunx", args = { "prettier", "--stdin-filepath", "$FILENAME" } },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "ruff_organize_imports" },
        ruby = { "standardrb" },
        go = { "gofmt" },
        typescript = { "prettier" },
        javascript = { "prettier" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
    },
  },
}
