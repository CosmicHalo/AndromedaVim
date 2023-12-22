---@class Andromeda
Andromeda = {
  icons = require("andromedavim.icons"),
  text_icons = require("andromedavim.icons.text"),
  settings = require("config") --[[@as AndromedaSettings]],
}

---@class AndromedaKit
Andromeda.kit = {}
---@class AndromedaConfigs
Andromeda.configs = {}
---@class AndromedaMappings
Andromeda.mappings = {}

--! Load all kits
local kits = vim.split(vim.fn.glob(Globals.vim_path .. "/lua/andromedavim/kit/*.lua"), "\n")
for _, k in ipairs(kits) do
  require("andromedavim.kit." .. k:match("^.+/(.+)$"):gsub(".lua", ""))
end
