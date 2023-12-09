---@alias StringMap table<string,string>

---@class AndromedaUIFileIconHighlights
---@field tabline AndromedaUIIconHighlights? enable or disabling file icon highlighting in the tabline
---@field statusline AndromedaUIIconHighlights? enable or disable file icon highlighting in the statusline

---@class AndromedaUIIconHighlights
---@field breadcrumbs AndromedaUIIconHighlights? enable or disable breadcrumb icon highlighting
---@field file_icon AndromedaUIFileIconHighlights?

---@class AndromedaUISeparators
---@field none string[]? placeholder separator for elements with "no" separator, typically two empty strings
---@field left string[]? Separators used for elements designated as being on the left of the statusline
---@field right string[]? Separators used for elements designated as being on the right of the statusline
---@field center string[]? Separators used for elements designated as being in the center of the statusline
---@field tab string[]? Separators used for tabs rendered in the tabline
---@field breadcrumbs string? Separator used in between symbols in the breadcrumbs
---@field path string? Separator used in between symbols in a file path

---@class AndromedaUIStatusOpts
---@field setup_colors (fun():table)?
---@field modes table<string,string[]>?
---@field attributes table<string,string>
---@field separators AndromedaUISeparators?
---@field buf_matchers table<string,string>
---@field fallback_colors table<string,string>
---@field icon_highlights AndromedaUIIconHighlights?
---@field sign_handlers table<string,fun(args:table)>?
---@field colors (StringMap|(fun(colors:StringMap):StringMap))?

---@class AndromedaUIOpts
---@field colorscheme string?
---@field highlights  table<string,(table<string,table>|fun():table<string,table>)>?
---@field icons StringMap?
---@field text_icons StringMap?
---@field status AndromedaUIStatusOpts?

---@type AndromedaUIOpts
local M = {
  highlights = {},
  colorscheme = nil,

  icons = {},
  text_icons = {},

  status = {
    attributes = {},
    buf_matchers = {},
    colors = {},
    fallback_colors = {},
    icon_highlights = {},
    modes = {},
    separators = {},
    setup_colors = nil,
    sign_handlers = {},
  },
}

return M
