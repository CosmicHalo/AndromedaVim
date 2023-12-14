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
--! >>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<< --

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

-- >>>>>>>>>>>>>>>>>>>>> Table <<<<<<<<<<<<<<<<<<<< --

---@param t table<string, any>
function M.get_keys(t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
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
function M.extend_opts(opts, extension) return M.extend_tbl(opts, extension) end