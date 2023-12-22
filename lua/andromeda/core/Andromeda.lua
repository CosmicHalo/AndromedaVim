---@class Andromeda
Andromeda = {
  icons = require("andromeda.icons"),
  text_icons = require("andromeda.icons.text"),
  settings = require("config") --[[@as AndromedaSettings]],
}

---@class AndromedaKit
Andromeda.kit = {}
---@class AndromedaConfigs
Andromeda.configs = {}
---@class AndromedaMappings
Andromeda.mappings = {}

--! Load all kits
local kits = vim.split(vim.fn.glob(Globals.vim_path .. "/lua/andromeda/kit/*.lua"), "\n")
for _, k in ipairs(kits) do
  require("andromeda.kit." .. k:match("^.+/(.+)$"):gsub("%..+$", ""))
end
