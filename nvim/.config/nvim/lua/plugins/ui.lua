return {
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      },
    },
  },

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup({
        options = {}
      })
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    keys = { { "<C-n>", ":Neotree filesystem reveal toggle left<CR>", desc = "Toggle Neo-tree" } },
    opts = {
      close_if_last_window = false,
      use_libuv_file_watcher = true,
      filesystem = {
        filtered_items = { visible = true, hide_dotfiles = false, hide_gitignored = false, hide_hidden = false },
        follow_current_file = { enabled = true, leave_dirs_open = true },
      },
      window = { width = 30, mappings = { ["<BS>"] = "delete" } },
    },
  },

  {
    dir = vim.fn.stdpath("config") .. "/lua",
    name = "ghostty",
    lazy = false,
    priority = 1000,
    config = function()
      require("custom.ghostty").set()
    end,
  }
}
