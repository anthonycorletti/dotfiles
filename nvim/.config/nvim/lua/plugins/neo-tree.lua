return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = 'v3.x',
  dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
    local neotree = require("neo-tree")
    neotree.setup {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        }
      }
    }
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal toggle left<CR>", {})
	end,
}
