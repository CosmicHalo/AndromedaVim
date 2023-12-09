---@class AndromedaLib: LazyUtilCore
---@field path AndromedaPathLib
local M = setmetatable({}, {
  __index = function(t, k)
    if require("lazy.core.util")[k] then return require("lazy.core.util")[k] end
    t[k] = require("libs." .. k)
    return t[k]
  end,
})

---------------------------
--! Misc Helpers
---------------------------

--- Wrap a function with arguments_list
---@param fn function The function to wrap
---@vararg any The arguments to pass to the function
---@return function # The wrapped function
function M.fn_wrap(fn, ...)
  local args = { ... } or {}
  fn = fn or require
  return function() fn(unpack(args)) end
end

function M.is_win() return vim.loop.os_uname().sysname:find "Windows" ~= nil end

function M.load_mappings(plugin) return require("andromedavim.plugins.configs." .. plugin).mappings or {} end

return M
