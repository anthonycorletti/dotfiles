return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize" },
    },
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        nested = true,
        callback = function()
          if vim.fn.argc() == 0 then
            require("persistence").load()
          end
        end,
      })
    end,
    config = function(_, opts)
      local persistence = require("persistence")
      persistence.setup(opts)

      vim.api.nvim_create_user_command("SessionNew", function()
        persistence.stop()
        vim.cmd("%bd!")
        vim.cmd("enew")
        print("Started fresh session")
      end, {})

      vim.api.nvim_create_user_command("SessionClear", function()
        local dir = vim.fn.stdpath("state") .. "/sessions"
        vim.fn.delete(dir, "rf")
        vim.fn.mkdir(dir, "p")
        print("Cleared all sessions")
      end, {})
    end,
  },
}
