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
LoadDirectory("kit")
LoadDirectory("modules/configs")
LoadDirectory("modules/mappings")
