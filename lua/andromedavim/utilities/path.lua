---@type AndromedaPathLib
Andromeda.lib.path = {}

---@class AndromedaPathLib
local M = Andromeda.lib.path

M.INIT_EXT = "init.lua"
M.CONFIG_PATH = vim.fn.stdpath("config") .. "/lua/"

M.filters = {}

-- >>>>>>>>>>>>>>>>>> Filters <<<<<<<<<<<<<<<<<<<< --

M.filters.lua = function(v, k, t) return M.get_filename(v) == M.INIT_EXT and false or true end

M.filters.utils = function(v, k, t)
  local is_lua = M.filters.lua(v, k, t)
  local is_path = M.get_filename(v) == "path.lua" and false or true
  return not is_lua and not is_path
end

-- >>>>>>>>>>>>>>>>>> Helpers <<<<<<<<<<<<<<<<<<<< --

---@param path string
---@return string
function M.get_filename(path) return path:match("^.+/(.+)$") end

---@param dir string
---@param filter? function
---@return string[]
function M.get_files(dir, filter)
  local path = (M.CONFIG_PATH .. dir:gsub("%.", "/"))
  local files = vim.split(vim.fn.glob(path .. "/*"), "\n", { trimempty = true })
  if filter then files = table.filter(files, filter) end
  return files
end

---@param dir string
---@param filter? function
function M.load_dir(dir, filter)
  filter = filter or M.filters.lua
  for _, file in ipairs(M.get_files(dir, filter)) do
    require(file:gsub(M.CONFIG_PATH, ""):gsub(".lua", ""))
  end
end
