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
    local devicons = require("nvim-web-devicons")
    -- set the vercel.json file icon to the same as json because it's a chinese character on ghostty
    devicons.setup({
      override = {
        ["vercel.json"] = devicons.get_icons_by_extension()["json"],
      },
    })
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
