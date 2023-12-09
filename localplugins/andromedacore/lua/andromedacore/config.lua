---@class AndromedaCoreOpts
---@field commands table<string,table|false>?
---@field autocmds table<string,table[]|false>?
---@field on_keys table<string,fun(key:string)[]|false>?
---@field mappings table<string,table<string,(table|string|false)?>?>?

---@type AndromedaCoreOpts
local M = {
  autocmds = {},
  commands = {},
  mappings = {},
  on_keys = {},
  features = {
    autopairs = true,
    cmp = true,
    highlighturl = true,
    max_file = { size = 1024 * 100, lines = 10000 },
    notifications = true,
  },
  git_worktrees = nil,
  sessions = {
    autosave = { last = true, cwd = true },
    ignore = {
      dirs = {},
      filetypes = { "gitcommit", "gitrebase" },
      buftypes = {},
    },
  },
}

return M
