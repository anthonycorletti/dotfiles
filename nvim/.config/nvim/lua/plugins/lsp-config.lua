return {
  -- language servers are installed via brew or relevant package manager
  -- and placed in PATH, no mason/mason-lspconfig needed
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      -- typescript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })

      -- python
      lspconfig.ruff.setup({
        capabilities = capabilities,
      })

      -- ruby
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
      })

      -- html
      lspconfig.html.setup({
        capabilities = capabilities,
      })

      -- tailwindcss
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
      })

      -- bash
      lspconfig.bashls.setup({
        capabilities = capabilities,
      })

      -- go
      lspconfig.gopls.setup({
        capabilities = capabilities,
      })

      -- rust
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
      })

      -- zig
      lspconfig.zls.setup({
        capabilities = capabilities,
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
    end,
  },
}
