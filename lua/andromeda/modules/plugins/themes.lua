local settings = Andromeda.settings
local enabled_themes = settings.theme.enabled_themes

local colorschemes = {
  { "lvim-tech/lvim-colorscheme", cfg = "themes.lvim" },
  { "olimorris/onedarkpro.nvim", cfg = "themes.onedark" },
  { "maxmx03/fluoromachine.nvim", cfg = "themes.fluoromachine" },
  { "craftzdog/solarized-osaka.nvim", cfg = "themes.solarized_osaka" },
  { "catppuccin/nvim", name = "catppuccin", cfg = "themes.catppuccin" },
  { "folke/tokyonight.nvim", branch = "main", cfg = "themes.tokyonight" },
}

colorschemes = table.map(colorschemes, function(_, theme)
  local theme_key = theme.name or Andromeda.kit.path.get_filename(theme[1], false)

  local config = theme.cfg and require(theme.cfg) or {}
  theme = table.extend(
    theme,
    { lazy = false, priority = 1000, enabled = table.find(enabled_themes, theme_key) ~= nil },
    config
  )

  return theme
end)

return {
  colorschemes,

  {
    "NvChad/nvim-colorizer.lua",
    event = "User AstroFile",
    opts = { user_default_options = { names = false } },
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>uz"] = { "<Cmd>ColorizerToggle<CR>", desc = "Toggle color highlight" }
        end,
      },
    },
  },
}
