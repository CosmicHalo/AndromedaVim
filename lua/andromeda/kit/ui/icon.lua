---@class AndromedaUIKit
local M = Andromeda.kit.ui

--- Get an icon from the internal icons if it is available and return it
---@param categoryOrKind string The category of icon to retrieve or the icon itself
---@param padding? integer Padding to add to the end of the icon, defaults to 1
---@param wrap? boolean Whether or not to wrap both sides of the icon with spaces
---@return string icon
M.get_icon = function(categoryOrKind, padding, wrap)
  ---@cast categoryOrKind string

  local icons_enabled = vim.g.icons_enabled ~= false
  local icon_pack = assert(Andromeda[icons_enabled and "icons" or "text_icons"])

  local icon = icon_pack
  for _, path in ipairs(string.split(categoryOrKind, ".")) do
    icon = icon[path]
  end

  if not icon then return "" end

  -- Wrap the icon in spaces if requested
  local spacing = string.rep(" ", padding or 1)
  if wrap then return spacing .. icon .. spacing end
  return icon .. spacing
end

return M
