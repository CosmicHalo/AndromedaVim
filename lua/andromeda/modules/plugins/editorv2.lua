local settings = Andromeda.settings.plugins

local editor = {
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  { "LunarVim/bigfile.nvim", config = require("configs.bigfile") },
}

return editor
