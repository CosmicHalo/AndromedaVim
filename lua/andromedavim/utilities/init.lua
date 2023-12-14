---@class AndromedaLib: LazyUtilCore
---@field path AndromedaPathLib
local M = setmetatable(Andromeda.lib, {
  __index = function(t, k)
    if require("lazy.core.util")[k] then return require("lazy.core.util")[k] end
    return Andromeda.lib[k]
  end,
})

--! >>>>>>>>>>>>>> Load Utilities <<<<<<<<<<<<<< --
local utils = {
  "extensions",
  "format",
  "lsp",
  "path",
  "root",
  "telescope",
  "ui",
}
for _, util in ipairs(utils) do
  require("andromedavim.utilities." .. util)
end
--! >>>>>>>>>>>>>>>>>>>>>>>>> <<<<<<<<<<<<<<<<<<<<<< --

function M.is_win() return vim.loop.os_uname().sysname:find("Windows") ~= nil end

---@param plugin string
function M.has(plugin) return require("lazy.core.config").spec.plugins[plugin] ~= nil end

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
