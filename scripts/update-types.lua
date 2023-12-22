local normalize = vim.fs.normalize
local fnamemodify = vim.fn.fnamemodify

local types_fp = fnamemodify(normalize(debug.getinfo(1, "S").source:sub(2)), ":p:h:h") .. "/types"

local write_file = function(path, content)
  local file = assert(io.open(path, "w+"))
  file:write(content)
  file:close()
end

local function toUpper(str) return (str:gsub("^%l", string.upper)) end

local function get_keys(t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end

local gen_icon_types = function()
  _G.Andromeda = {}
  _G.Andromeda.icons = {}
  local icons = require("andromeda.icons")

  local contents = {
    "---@meta",
    "--- Don't edit or require this file",
    'error("Requring a meta file")',
  }

  local andomedaicons = get_keys(Andromeda.icons)
  table.sort(andomedaicons)

  local IconPackNames = {}
  for _, typ in next, andomedaicons do
    if typ == "get" then goto continue end

    local icon_pack = Andromeda.icons[typ]
    local IconPackName = toUpper(typ) .. "Icons"
    table.insert(IconPackNames, IconPackName)
    table.insert(contents, "\n---@alias " .. IconPackName)

    local count = 0
    for name, _ in pairs(icon_pack) do
      table.insert(contents, "---| " .. '"' .. typ .. "." .. name .. '"')
      count = count + 1
    end

    ::continue::
  end

  local IconType = "---@alias Icons "
  for i, IconPackName in ipairs(IconPackNames) do
    local sep = i > 1 and " | " or ""
    IconType = IconType .. sep .. IconPackName .. " "
  end

  write_file(types_fp .. "/icons.lua", table.concat(contents, "\n") .. "\n\n" .. IconType)
end

gen_icon_types()
