---@class AndromedaUIKit
local M = Andromeda.kit.ui

--! <<<<<<<<<<< Colorschemes >>>>>>>>>>>>> --

---@param theme string
M.is_theme_active = function(theme)
  return Andromeda.settings.theme.enabled_themes[theme] ~= nil and theme == Andromeda.settings.theme.enabled
end

---@param theme string
M.set_colorscheme = function(theme)
  Andromeda.kit.try(function() vim.cmd.colorscheme(theme) end, {
    on_error = function()
      Andromeda.kit.notify(("Error setting up colorscheme: `%s`"):format(theme), vim.log.levels.ERROR)
    end,
  })
end

---@param scheme string
---@param setup_fn function
---@param activate_theme? boolean
M.activate_colorscheme = function(scheme, setup_fn, activate_theme)
  local active_theme = Andromeda.settings.theme.enabled

  if active_theme == scheme then
    activate_theme = activate_theme or M.is_theme_active(scheme) or false

    Andromeda.kit.try(function()
      setup_fn()
      if activate_theme then M.set_colorscheme(scheme) end
    end, {
      on_error = function()
        Andromeda.kit.notify(("Error activating colorscheme: `%s`"):format(scheme), vim.log.levels.ERROR)
      end,
    })
  end
end

return M
