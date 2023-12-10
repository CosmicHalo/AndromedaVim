---@class AndromedaLib: LazyUtilCore
---@field lsp AndromedaLSPLib
---@field path AndromedaPathLib
---@field root AndromedaRootLib
---@field format AndromedaFormatLib
---@field telescope AndromedaTelescopeLib
local M = setmetatable({}, {
  __index = function(t, k)
    if require("lazy.core.util")[k] then return require("lazy.core.util")[k] end
    t[k] = require("andromedavim.libs." .. k)
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
  return function() fn(table.unpack(args)) end
end

function M.is_win() return vim.loop.os_uname().sysname:find "Windows" ~= nil end

---@param plugin string
function M.has(plugin) return require("lazy.core.config").spec.plugins[plugin] ~= nil end

---@param fn fun()
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", { pattern = "VeryLazy", callback = function() fn() end })
end

return M
