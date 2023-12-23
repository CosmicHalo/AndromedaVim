---@class AndromedaKit: LazyUtilCore
---@field ui AndromedaUIKit
---@field lsp AndromedaLspKit
---@field root AndromedaRootKit
---@field format AndromedaFormatKit
---@field keymap AndromedaKeymapKit
---@field telescope AndromedaTelescopeKit
local M = setmetatable(Andromeda.kit, {
  __index = function(t, k)
    if require("lazy.core.util")[k] then return require("lazy.core.util")[k] end
    t[k] = require("andromeda.kit." .. k)
    return t[k]
  end,
})

function M.is_win() return vim.loop.os_uname().sysname:find("Windows") ~= nil end

--- Serve a notification with a title of AndromedaVim
---@param msg string The notification body
---@param type? string|number The type of the notification (:help vim.log.levels)
---@param opts? table The nvim-notify options to use (:help notify-options)
function M.notify(msg, type, opts)
  type = type or vim.log.levels.INFO
  vim.schedule(function() vim.notify(msg, type, table.extend({ title = "AndromedaVim" }, opts)) end)
end

-- delay notifications till vim.notify was replaced or after 500ms
function M.lazy_notify()
  local notifs = {}
  local function temp(...) table.insert(notifs, vim.F.pack_len(...)) end

  local orig = vim.notify
  vim.notify = temp

  local timer = vim.loop.new_timer()
  local check = assert(vim.loop.new_check())

  local replay = function()
    timer:stop()
    check:stop()

    if vim.notify == temp then
      vim.notify = orig -- put back the original notify if needed
    end

    vim.schedule(function()
      ---@diagnostic disable-next-line: no-unknown
      for _, notif in ipairs(notifs) do
        vim.notify(vim.F.unpack_len(notif))
      end
    end)
  end

  -- wait till vim.notify has been replaced
  check:start(function()
    if vim.notify ~= temp then replay() end
  end)

  -- or if it took more than 500ms, then something went wrong
  timer:start(500, 0, replay)
end

return M
