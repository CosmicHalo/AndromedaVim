---@class AndromedaKit: LazyUtilCore
---@field ui AndromedaUIKit
---@field lsp AndromedaLspKit
---@field root AndromedaRootKit
---@field format AndromedaFormatKit
---@field keymap AndromedaKeymapKit
---@field telescope AndromedaTelescopeKit
local M = setmetatable(Andromeda.kit, {
  __index = function(t, k)
    if require("andromeda.kit." .. k) then return require("andromeda.kit." .. k) end
    if require("lazy.core.util")[k] then return require("lazy.core.util")[k] end
    t[k] = nil
    return t[k]
  end,
})

function M.is_win() return vim.loop.os_uname().sysname:find("Windows") ~= nil end

M.get_nvim_version = function()
  local version = vim.version()
  local is_prerelease = version.api_prerelease or false
  local prerelease = is_prerelease and "-" .. version.prerelease or ""
  return version.major .. "." .. version.minor .. "." .. version.patch .. prerelease
end

-- >>>>>>>>>>>>>>>>>>>>> Table <<<<<<<<<<<<<<<<<<<< --

--- Insert one or more values into a list like table and maintain that you do not insert non-unique values (THIS MODIFIES `lst`)
---@param lst any[]|nil The list like table that you want to insert into
---@param vals any|any[] Either a list like table of values to be inserted or a single value to be inserted
---@return any[] # The modified list like table
function M.list_insert_unique(lst, vals)
  if not lst then lst = {} end
  assert(vim.tbl_islist(lst), "Provided table is not a list like table")
  if not vim.tbl_islist(vals) then vals = { vals } end

  local added = {}
  vim.tbl_map(function(v) added[v] = true end, lst)
  for _, val in ipairs(vals) do
    if not added[val] then
      table.insert(lst, val)
      added[val] = true
    end
  end

  return lst
end

---@param opts table
---@param key? string
---@param extension table
function M.extend_list_opt(opts, extension, key)
  opts = opts or {}
  key = key or "ensure_installed"
  opts[key] = opts[key] or {}
  return vim.list_extend(opts[key] or {}, extension)
end

---@param opts table
---@param extension table
function M.extend_opts(opts, extension) return table.extend(opts, extension) end

return M
