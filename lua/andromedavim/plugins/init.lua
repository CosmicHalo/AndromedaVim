Andromeda.lib.path.load_dir("andromedavim.plugins._configs")
Andromeda.lib.path.load_dir("andromedavim.plugins._mappings")

local plugins = {
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",
  -- NOTE: First, some plugins that don't require any configuration
  "nvim-lua/plenary.nvim",
}

for _, plugin in ipairs({
  "core",
  "lsp",
  "formatters",
  "lang",
  "ui",
  "coding",
  --   "editor",
}) do
  table.insert(plugins, { import = "andromedavim.plugins." .. plugin })
end

return plugins
