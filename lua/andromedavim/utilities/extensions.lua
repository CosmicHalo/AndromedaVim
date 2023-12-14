table.filter = function(t, filterIter)
  local out = {}

  for k, v in pairs(t) do
    if filterIter(v, k, t) then table.insert(out, v) end
  end

  return out
end

---@param str string
---@param sep? string
string.split = function(str, sep)
  local sep, res = sep or "%s", {}
  local _ = string.gsub(str --[[@as string]], "[^" .. sep .. "]+", function(x) res[#res + 1] = x end)
  return res
end
