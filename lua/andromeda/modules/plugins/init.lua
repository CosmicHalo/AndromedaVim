require("andromeda.core").init()

Andromeda.kit.path.load_dir("andromeda.modules.configs")
Andromeda.kit.path.load_dir("andromeda.modules.mappings")

local plugins = {
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  "nvim-lua/plenary.nvim", -- NOTE: First, some plugins that don't require any configuration
  { "LunarVim/bigfile.nvim", opts = require("andromeda.modules.configs.bigfile") },
  { "folke/lazy.nvim", version = false },
}

for _, plugin in ipairs({
  "core",
  "coding",
  "editor",
  "formatting",
  "lang",
  "ui",
  "lsp",
}) do
  table.insert(plugins, { import = "andromeda.modules.plugins." .. plugin })
end

return plugins
