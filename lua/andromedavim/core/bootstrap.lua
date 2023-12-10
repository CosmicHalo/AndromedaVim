---@class GlobalAndromeda
_G.Andromeda = {}

Andromeda.debug = function(...)
  local args = { ... }
  local str = ""

  for i, v in ipairs(args) do
    str = str .. vim.inspect(v)
    if i ~= #args then str = str .. ", " end
  end

  vim.api.nvim_echo({ { str } }, true, {})
  vim.fn.getchar()
end

---@param str string
---@param key_return? boolean
Andromeda.echo = function(str, key_return)
  vim.cmd "redraw"
  vim.api.nvim_echo({ { str, "Bold" } }, true, {})
  if key_return then vim.fn.getchar() end
end

Andromeda.load_config = function(plugin, ...)
  local args = { ... } or {}
  return require("andromedavim.plugins._configs." .. plugin) or {}
end

Andromeda.load_cfg = function(plugin)
  local lib = require "andromedavim.libs"
  local pathlib = lib.path

  -- Check if plugin is a path, if so, load it directly
  local has_dot = string.find(plugin, "%.") ~= nil
  if has_dot then return lib.fn_wrap(require, string.format("plugins.%s", plugin)) end

  local filename = pathlib.get_filename(pathlib.get_path_dir())
  local plugin_path = string.format("plugins.%s.%s", filename, plugin)
  return lib.fn_wrap(require, plugin_path)
end
