local settings = Andromeda.settings

return {
  opts = { transparent = settings.theme.enable_transparent },
  config = function(_, opts)
    Andromeda.kit.ui.activate_colorscheme(
      "solarized-osaka",
      function() require("solarized-osaka").setup(opts) end,
      true
    )
  end,
}
