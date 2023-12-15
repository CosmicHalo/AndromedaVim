Andromeda.lib.path.load_dir("andromedavim.plugins._configs")
Andromeda.lib.path.load_dir("andromedavim.plugins._mappings")

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
  table.insert(plugins, { import = "andromedavim.plugins." .. plugin })
end

return plugins
