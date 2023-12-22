---@type AndromedaPathKit
Andromeda.kit.path = {}

---@class AndromedaPathKit
local M = Andromeda.kit.path

M.INIT_FILE = "init"
M.CONFIG_PATH = vim.fn.stdpath("config") .. "/lua/"

-- >>>>>>>>>>>>>>>>>> Filters <<<<<<<<<<<<<<<<<<<< --
M.filters = {
  lua = function(v, k, t) return M.get_filename(v) == M.INIT_FILE and false or true end,
}

-- >>>>>>>>>>>>>>>>>> Helpers <<<<<<<<<<<<<<<<<<<< --

---@param path string
---@param with_ext? boolean
---@return string
function M.get_filename(path, with_ext)
  with_ext = with_ext or false
  local filename = path:match("^.+/(.+)$")
  if with_ext then return filename end
  return filename:gsub("%..+$", "")
end

---@param dir string
---@param filter? function
---@return string[]
function M.get_lua_files(dir, filter)
  local path = (M.CONFIG_PATH .. dir:gsub("%.", "/"))
  local files = vim.split(vim.fn.glob(path .. "/*.lua"), "\n", { trimempty = true })
  if filter then files = table.filter(files, filter) end
  return files
end

---@param dir string
---@param filter? function
function M.load_dir(dir, filter)
  filter = filter or M.filters.lua
  for _, file in ipairs(M.get_lua_files(dir, filter)) do
    local config_path = string.gsub(M.CONFIG_PATH, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
    require(file:gsub(config_path, ""):gsub(".lua", ""))
  end
end
