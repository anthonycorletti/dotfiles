return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local neotree = require("neo-tree")
    neotree.setup({
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
      },
    })
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal toggle left<CR>", {})
  end,
}
