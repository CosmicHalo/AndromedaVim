require("andromeda.core").init()

local plugins = { "nvim-lua/plenary.nvim", { "folke/lazy.nvim", version = false } }

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
