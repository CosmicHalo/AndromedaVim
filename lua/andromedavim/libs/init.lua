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

--- Trigger an AstroNvim user event
---@param event string The event name to be appended to Astro
function M.event(event)
  vim.schedule(function() vim.api.nvim_exec_autocmds("User", { pattern = "Andromeda" .. event, modeline = false }) end)
end

---@param fn fun()
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", { pattern = "VeryLazy", callback = function() fn() end })
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
function M.extend_opts(opts, extension) return require("astrocore").extend_tbl(opts, extension) end

return M
