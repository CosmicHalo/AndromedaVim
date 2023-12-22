require("andromedavim.core").init()

Andromeda.kit.path.load_dir("andromedavim.modules.configs")
Andromeda.kit.path.load_dir("andromedavim.modules.mappings")

local plugins = {
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  "nvim-lua/plenary.nvim", -- NOTE: First, some plugins that don't require any configuration
  { "LunarVim/bigfile.nvim", config = Andromeda.configs.bigfile },
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
  table.insert(plugins, { import = "andromedavim.modules.plugins." .. plugin })
end

return plugins
