--! Table

table.filter = function(t, filterIter)
  local out = {}
  for k, v in pairs(t) do
    if filterIter(v, k, t) then table.insert(out, v) end
  end
  return out
end

---@param t table<string, any>
table.keys = function(t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end

---@generic T
---@param t table
---@param mapIter fun(key: string, value: T,  table: table): T
table.map = function(t, mapIter)
  local out = {}

  ---@param k string
  ---@param v `T`
  for k, v in vim.iter(pairs(t)) do
    out[k] = mapIter(k, v, t)
  end

  return out
end

---@param table table
---@param value any
table.find = function(table, value)
  for key, _value in pairs(table) do
    if type(_value) == "table" then
      local f = { table.find(_value, value) }
      if #f ~= 0 then
        table.insert(f, 2, key)
        return table.unpack(f)
      end
    elseif _value == value or key == value then
      return _value
      -- return key, _value
    end
  end
end

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param ... table The new options that should be merged with the default table
---@return table # The merged table
table.extend = function(default, ...)
  local table_of_opts = { ... }
  for _, opts in ipairs(table_of_opts) do
    opts = opts or {}
    default = default and vim.tbl_deep_extend("force", default, opts) or opts
  end

  return default
end

--! String

function string.is_not_empty(s) return not s:is_empty() end
function string.is_empty(s) return s == nil or s == "" end

---@param str string
---@param sep? string
string.split = function(str, sep)
  local sep, res = sep or "%s", {}
  local _ = string.gsub(str --[[@as string]], "[^" .. sep .. "]+", function(x) res[#res + 1] = x end)
  return res
end

string.concat = function(...)
  local strings = { ... }
  local str = ""
  for _, s in ipairs(strings) do
    str = str .. s
  end
  return str
end
