---@alias GetWrapIconFunction<T> fun(kind: T, padding?: integer): string
---@alias GetIconFunction<T> fun(kind: T, padding?: integer, wrap?: boolean): string

--- Get an icon from the internal icons if it is available and return it
---@param categoryOrKind string The category of icon to retrieve or the icon itself
---@param padding? integer Padding to add to the end of the icon, defaults to 1
---@param wrap? boolean Whether or not to wrap both sides of the icon with spaces
---@return string icon
local function get_icon(categoryOrKind, padding, wrap)
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

---@param pack string
---@param is_wrap? boolean
local function generate_get(pack, is_wrap)
  is_wrap = is_wrap or false
  if is_wrap then return function(iconType, padding) return get_icon(pack .. "." .. iconType, padding, true) end end
  return function(iconType, padding, wrap) return get_icon(pack .. "." .. iconType, padding, wrap) end
end

local andomedaicons = Andromeda.lib.get_keys(Andromeda.icons)

---@param typ "ui"|"misc"|"lsp"|"cmp"|"dap"|"git"|"kind"|"type"|"documents"|"diagnostics"
for _, typ in next, andomedaicons do
  Andromeda.icons[typ].get = generate_get(typ)
  Andromeda.icons[typ].get_wrapped = generate_get(typ, true)
end

--! UI
Andromeda.icons.ui.get = generate_get("ui") --[[@as GetIconFunction<UIIcons>]]
Andromeda.icons.ui.get_wrapped = generate_get("ui", true) --[[@as GetIconFunction<UIIcons>]]

--! Misc
Andromeda.icons.misc.get = generate_get("misc") --[[@as GetIconFunction<MiscIcons>]]
Andromeda.icons.misc.get_wrapped = generate_get("misc", true) --[[@as GetIconFunction<MiscIcons>]]

--! LSP
Andromeda.icons.lsp.get = generate_get("lsp") --[[@as GetIconFunction<LSPIcons>]]

--! CMP
Andromeda.icons.cmp.get = generate_get("cmp") --[[@as GetIconFunction<CmpIcons>]]

--! DAP
Andromeda.icons.dap.get = generate_get("dap") --[[@as GetIconFunction<DapIcons>]]

--! Git
Andromeda.icons.git.get = generate_get("git") --[[@as GetIconFunction<GitIcons>]]

--! Kind
Andromeda.icons.kind.get = generate_get("kind") --[[@as GetIconFunction<KindIcons>]]

--! Type
Andromeda.icons.type.get = generate_get("type") --[[@as GetIconFunction<TypeIcons>]]

--! Documents
Andromeda.icons.documents.get = generate_get("documents") --[[@as GetIconFunction<DocumentIcons>]]

--! Diagnostics
Andromeda.icons.diagnostics.get = generate_get("diagnostics") --[[@as GetIconFunction<DiagnosticsIcons>]]
