---@class NeovimPlugin table<string, any>
---@field setup fun(opts: table<string, any>)

--! Diagnostic severity
vim.diagnostic.severity = {
  ERROR = 1,
  WARN = 2,
  INFO = 3,
  HINT = 4,
}

--! Log levels
vim.log = {
  levels = {
    TRACE = 0,
    DEBUG = 1,
    INFO = 2,
    WARN = 3,
    ERROR = 4,
  },
}
