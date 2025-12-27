return {
  { "folke/lazydev.nvim", ft = "lua", opts = { library = { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "saghen/blink.cmp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          local tb = require("telescope.builtin")

          map("grn", vim.lsp.buf.rename, "Rename")
          map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
          map("grr", tb.lsp_references, "References")
          map("gri", tb.lsp_implementations, "Implementation")
          map("grd", tb.lsp_definitions, "Definition")
          map("grD", vim.lsp.buf.declaration, "Declaration")
          map("gO", tb.lsp_document_symbols, "Document Symbols")
          map("gW", tb.lsp_dynamic_workspace_symbols, "Workspace Symbols")
          map("grt", tb.lsp_type_definitions, "Type Definition")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local supports = function(method)
            if vim.fn.has("nvim-0.11") == 1 then return client:supports_method(method, event.buf)
            else return client.supports_method(method, { bufnr = event.buf }) end
          end

          if client and supports(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, { buffer = event.buf, group = group, callback = vim.lsp.buf.document_highlight })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { buffer = event.buf, group = group, callback = vim.lsp.buf.clear_references })
            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(e) vim.lsp.buf.clear_references(); vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = e.buf }) end,
            })
          end

          if client and supports(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end, "Toggle Inlay Hints")
          end
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many", header = "", prefix = "" },
        underline = { severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN, vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT } },
        signs = vim.g.have_nerd_font and { text = { [vim.diagnostic.severity.ERROR] = "󰅚 ", [vim.diagnostic.severity.WARN] = "󰀪 ", [vim.diagnostic.severity.INFO] = "󰋽 ", [vim.diagnostic.severity.HINT] = "󰌶 " } } or {},
        virtual_text = false,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local servers = {
        gopls = {}, rust_analyzer = {}, ts_ls = {},
        ruff = { settings = { args = { "--config=pyproject.toml" } } },
        lua_ls = { settings = { Lua = { completion = { callSnippet = "Replace" } } } },
        ruby_lsp = { settings = { rubyLsp = { formatter = "standard" } } },
      }

      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, { "stylua", "ruff", "standardrb", "prettier", "prettierd" })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
