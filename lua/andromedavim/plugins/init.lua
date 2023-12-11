local plugins = {
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- NOTE: First, some plugins that don't require any configuration
  "nvim-lua/plenary.nvim",
}

require("andromedavim.libs.path").load_dir()

for _, plugin in ipairs {
  "core",
  "lsp",
  "formatters",
  "lang",
  "ui",
  "coding",
  "editor",
} do
  table.insert(plugins, { import = "andromedavim.plugins." .. plugin })
end

return plugins
