return {
  { "folke/lazydev.nvim", ft = "lua", opts = { library = { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- LSP keymaps
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
        virtual_text = false,
      })

      -- Servers + tools
      local servers = {
        gopls = {},
        rust_analyzer = {},
        zls = {},
        ts_ls = {},
        ruff = {},
        ty = {},
        lua_ls = { settings = { Lua = { completion = { callSnippet = "Replace" } } } },
        ruby_lsp = { settings = { rubyLsp = { formatter = "standard" } } },
      }

      local tools = { "stylua", "prettierd", "standardrb" }

      require("mason-tool-installer").setup({
        ensure_installed = vim.list_extend(vim.tbl_keys(servers), tools),
      })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local config = servers[server_name] or {}
            config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
            require("lspconfig")[server_name].setup(config)
          end,
        },
      })
    end,
  },
}
