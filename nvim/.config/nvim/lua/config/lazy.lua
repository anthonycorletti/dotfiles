local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
  vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" })
end

vim.opt.rtp:prepend(lazypath)

local opts = {
  spec = {
    { import = "plugins" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘", config = "🛠", event = "📅", ft = "📂", init = "⚙",
      keys = "🗝", plugin = "🔌", runtime = "💻", require = "🌙",
      source = "📄", start = "🚀", task = "📌", lazy = "💤 ",
    },
  },
}

require("lazy").setup(opts)
