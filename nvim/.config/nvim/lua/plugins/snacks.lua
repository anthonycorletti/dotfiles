return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = {
        enabled = true,
      },
      picker = {
        enabled = true,
        sources = {
          files = {
            hidden = true,   -- include dotfiles
            ignored = true,  -- include .gitignore'd files
          },
          grep = {
            hidden = true,
            ignored = true,
          },
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true, style = "minimal", top_down = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      image = { enabled = false },
    },
    keys = {
      -- Files
      { "<leader>sf", function() Snacks.picker.files() end,                desc = "[S]earch [F]iles" },
      { "<leader>sg", function() Snacks.picker.grep() end,                 desc = "[S]earch by [G]rep" },
      { "<leader>se", function() Snacks.picker.grep({ regex = false }) end, desc = "[S]earch [E]xact (literal)" },
      { "<leader>sw", function() Snacks.picker.grep_word() end,            desc = "[S]earch current [W]ord" },
      { "<leader>s.", function() Snacks.picker.recent() end,               desc = "[S]earch Recent Files" },
      { "<leader>sr", function() Snacks.picker.resume() end,               desc = "[S]earch [R]esume" },
      { "<leader>sk", function() Snacks.picker.keymaps() end,              desc = "[S]earch [K]eymaps" },
      { "<leader>ss", function() Snacks.picker.pickers() end,              desc = "[S]earch [S]elect picker" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end,          desc = "[S]earch [D]iagnostics" },
      { "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[S]earch [N]eovim config" },
      { "<leader><leader>", function() Snacks.picker.buffers() end,        desc = "Find buffers" },
      { "<leader>/",  function() Snacks.picker.lines() end,                desc = "Fuzzy search buffer" },
      { "<leader>s/", function() Snacks.picker.grep({ search_dirs = vim.tbl_map(function(b) return vim.api.nvim_buf_get_name(b) end, vim.api.nvim_list_bufs()) }) end, desc = "[S]earch in Open Files" },

      -- LSP
      { "grr", function() Snacks.picker.lsp_references() end,      desc = "LSP References" },
      { "gri", function() Snacks.picker.lsp_implementations() end, desc = "LSP Implementations" },
      { "grd", function() Snacks.picker.lsp_definitions() end,     desc = "LSP Definitions" },
      { "grt", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP Type Definitions" },
      { "gO",  function() Snacks.picker.lsp_symbols() end,         desc = "LSP Document Symbols" },
      { "gW",  function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    },
  },
}
