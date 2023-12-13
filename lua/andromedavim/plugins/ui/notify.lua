return {
  "rcarriga/nvim-notify",
  lazy = true,
  init = function() require("astrocore").load_plugin_with_func("nvim-notify", vim, "notify") end,
  opts = {
    max_height = function() return math.floor(vim.o.lines * 0.75) end,
    max_width = function() return math.floor(vim.o.columns * 0.75) end,

    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 175 })
      if not require("astrocore").config.features.notifications then vim.api.nvim_win_close(win, true) end
      if not package.loaded["nvim-treesitter"] then pcall(require, "nvim-treesitter") end
      vim.wo[win].conceallevel = 3
      local buf = vim.api.nvim_win_get_buf(win)
      if not pcall(vim.treesitter.start, buf, "markdown") then vim.bo[buf].syntax = "markdown" end
      vim.wo[win].spell = false
    end,
  },
  config = function(_, opts)
    local notify = require "notify" --[[@as NeovimPlugin]]
    notify.setup(opts)
    vim.notify = notify
  end,
}
