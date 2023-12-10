local Utils = require "andromedavim.libs"

---@class AndromedaRootLib
---@overload fun(): string
local M = setmetatable({}, {
  __call = function(m) return m.get() end,
})

---@alias AndromedaRootFn fun(buf: number): (string|string[])
---@alias AndromedaRootSpec string | string[] | AndromedaRootFn

---@class AndromedaRoot
---@field paths string[]
---@field spec AndromedaRootSpec

---@type AndromedaRootSpec[]
M.spec = { "lsp", { ".git", "lua" }, "cwd" }

---@type table<number, string>
M.cache = {}

-------------------------------
-- Root detection
-------------------------------

M.detectors = {}

function M.detectors.cwd() return { vim.loop.cwd() } end

---@param patterns string[]|string
function M.detectors.pattern(buf, patterns)
  patterns = type(patterns) == "string" and { patterns } or patterns

  local path = M.bufpath(buf) or vim.loop.cwd()
  local pattern = vim.fs.find(patterns, { path = path, upward = true })[1]

  return pattern and { vim.fs.dirname(pattern) } or {}
end

-------------------------------
-- Root Helpers
-------------------------------

function M.realpath(path)
  if path == "" or path == nil then return nil end

  path = vim.loop.fs_realpath(path) or path
  return Utils.norm(path)
end

function M.bufpath(buf) return M.realpath(vim.api.nvim_buf_get_name(assert(buf))) end

function M.cwd() return M.realpath(vim.loop.cwd()) or "" end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@param opts? {normalize?:boolean}
---@return string
function M.get(opts)
  local buf = vim.api.nvim_get_current_buf()
  local ret = M.cache[buf]

  if not ret then
    local roots = M.detect { all = false }
    ret = roots[1] and roots[1].paths[1] or vim.loop.cwd()
    M.cache[buf] = ret
  end

  if opts and opts.normalize then return ret end
  return Utils.is_win() and ret:gsub("/", "\\") or ret
end

-------------------------------
-- Root
-------------------------------

function M.setup()
  vim.api.nvim_create_user_command(
    "AndromedaRoot",
    function() Utils.root.info() end,
    { desc = "AndromedaVim roots for the current buffer" }
  )

  vim.api.nvim_create_autocmd({ "LspAttach", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("andromedavim_root_cache", { clear = true }),
    callback = function(event) M.cache[event.buf] = nil end,
  })
end

---@param spec AndromedaRootSpec
---@return AndromedaRootFn
function M.resolve(spec)
  if M.detectors[spec] then
    return M.detectors[spec]
  elseif type(spec) == "function" then
    return spec
  end

  return function(buf) return M.detectors.pattern(buf, spec) end
end

function M.info()
  local spec = type(vim.g.root_spec) == "table" and vim.g.root_spec or M.spec

  local first = true
  local lines = {} ---@type string[]
  local roots = M.detect { all = true }

  for _, root in ipairs(roots) do
    for _, path in ipairs(root.paths) do
      lines[#lines + 1] = ("- [%s] `%s` **(%s)**"):format(
        first and "x" or " ",
        path,
        ---@diagnostic disable-next-line: param-type-mismatch
        type(root.spec) == "table" and table.concat(root.spec, ", ") or root.spec
      )

      if first then first = false end
    end
  end

  lines[#lines + 1] = "```lua"
  lines[#lines + 1] = "vim.g.root_spec = " .. vim.inspect(spec)
  lines[#lines + 1] = "```"

  require("andromedavim.libs").info(lines, { title = "AndromedaVim Roots" })
  return roots[1] and roots[1].paths[1] or vim.loop.cwd()
end

---@param opts? { buf?: number, spec?: AndromedaRootSpec[], all?: boolean }
function M.detect(opts)
  opts = opts or {}
  opts.spec = opts.spec or type(vim.g.root_spec) == "table" and vim.g.root_spec or M.spec
  opts.buf = (opts.buf == nil or opts.buf == 0) and vim.api.nvim_get_current_buf() or opts.buf

  local ret = {} ---@type AndromedaRoot[]
  for _, spec in ipairs(opts.spec) do
    local paths = M.resolve(spec)(opts.buf)

    paths = paths or {}
    paths = type(paths) == "table" and paths or { paths }

    local roots = {} ---@type string[]
    for _, p in ipairs(paths) do
      local pp = M.realpath(p)
      if pp and not vim.tbl_contains(roots, pp) then roots[#roots + 1] = pp end
    end

    table.sort(roots, function(a, b) return #a > #b end)

    if #roots > 0 then
      ret[#ret + 1] = { spec = spec, paths = roots }
      if opts.all == false then break end
    end
  end

  return ret
end

return M
