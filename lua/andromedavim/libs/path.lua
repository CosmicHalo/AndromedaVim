local Libs = require 'andromedavim.libs'

---@class AndromedaPathLib
local M = {}

function M.get_path_separator()
  return Libs.is_win() and '\\' or '/'
end

---@param path? string
---@return string
function M.get_path_dir(path)
  path = path or debug.getinfo(3).source:sub(2)
  if Libs.is_win() then
    path = path:gsub('/', '\\')
  end
  local dir = path:match('(.*' .. M.get_path_separator() .. ')') --[[@as string]]
  return dir:sub(-1, -1) == '/' and dir:sub(1, -2) or dir
end

---@param path string
---@return string
function M.get_filename(path)
  return path:match '^.+/(.+)$'
end

return M
