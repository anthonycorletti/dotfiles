return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = function() return vim.fn.executable("make") == 1 end },
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          file_ignore_patterns = { ".git/", "node_modules", "dist/", "build/", "vendor/", ".venv/", "__pycache__/", "*_cache/" },
          hidden = true,
          follow = true,
          vimgrep_arguments = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--hidden", "--no-ignore" },
        },
        pickers = {
          find_files = { hidden = true, no_ignore = true, follow = true },
          live_grep = { additional_args = function() return { "--hidden", "--no-ignore" } end },
        },
        extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown() } },
      })

      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")

      local map = vim.keymap.set
      map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      map("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files" })
      map("n", "<leader><leader>", builtin.buffers, { desc = "Find buffers" })
      map("n", "<leader>/", function() builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })) end, { desc = "Fuzzy search buffer" })
      map("n", "<leader>s/", function() builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" }) end, { desc = "[S]earch in Open Files" })
      map("n", "<leader>sn", function() builtin.find_files({ cwd = vim.fn.stdpath("config"), hidden = true, no_ignore = true }) end, { desc = "[S]earch Neovim config" })
    end,
  },
}
