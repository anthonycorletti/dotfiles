return {
  { "folke/lazydev.nvim", ft = "lua", opts = { library = { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
  { "saghen/blink.cmp", version = "1.*" },

  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          map("grn", vim.lsp.buf.rename, "Rename")
          map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
          map("grD", vim.lsp.buf.declaration, "Declaration")
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "Toggle Inlay Hints")
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        virtual_text = { severity = vim.diagnostic.severity.ERROR },
        float = { border = "rounded", source = "if_many" },
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.lsp.config("*", { capabilities = capabilities })

      vim.lsp.config("ruff", { cmd = { "uvx", "ruff", "server" } })
      vim.lsp.config("ty", { cmd = { "uvx", "ty", "server" }, filetypes = { "python" } })
      vim.lsp.config("ts_ls", { cmd = { "bunx", "typescript-language-server", "--stdio" } })
      vim.lsp.config("lua_ls", { settings = { Lua = { completion = { callSnippet = "Replace" } } } })
      vim.lsp.config("ruby_lsp", { settings = { rubyLsp = { formatter = "standard" } } })

      vim.lsp.enable({ "gopls", "rust_analyzer", "zls", "lua_ls", "ruff", "ty", "ruby_lsp", "ts_ls" })
    end,
  },
}
