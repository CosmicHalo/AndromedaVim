local settings = Andromeda.settings
local themes = { "delta", "retrowave", "default" } -- delta, retrowave, default
local theme = table.find(themes, settings.theme.style) or "retrowave"

local function overrides(c)
  return {
    TelescopePreviewNormal = { bg = c.bg },
    TelescopePromptPrefix = { fg = c.purple },
    TelescopeResultsNormal = { bg = c.alt_bg },
    TelescopeTitle = { fg = c.fg, bg = c.comment },
    TelescopePromptBorder = { fg = c.alt_bg, bg = c.alt_bg },
    TelescopeResultsBorder = { fg = c.alt_bg, bg = c.alt_bg },
  }
end

return {
  config = function()
    Andromeda.kit.ui.activate_colorscheme(
      "fluoromachine",
      function()
        require("fluoromachine").setup({
          glow = true,
          theme = theme,
          overrides = overrides,
          transparent = settings.theme.enable_transparent,
        })
      end
    )
  end,
}
