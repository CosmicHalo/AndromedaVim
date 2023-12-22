---@type AndromedaKeymapKit
Andromeda.kit.keymap = {}

---@class map_rhs
---@field [1] string | fun():nil
---@field desc string
---@field expr boolean
---@field silent boolean
---@field nowait boolean
---@field noremap boolean
---@field callback function
---@field buffer boolean|number
local rhs_options = {}

function rhs_options:new()
  local instance = {
    "",
    desc = "",
    expr = false,
    silent = false,
    nowait = false,
    callback = nil,
    buffer = false,
    noremap = false,
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

---@param cmd_string string
---@return map_rhs
function rhs_options:map_cmd(cmd_string)
  self[1] = cmd_string
  return self
end

---@param cmd_string string
---@return map_rhs
function rhs_options:map_cr(cmd_string)
  self[1] = (":%s<CR>"):format(cmd_string)
  return self
end

---@param cmd_string string
---@return map_rhs
function rhs_options:map_args(cmd_string)
  self[1] = (":%s<Space>"):format(cmd_string)
  return self
end

---@param cmd_string string
---@return map_rhs
function rhs_options:map_cu(cmd_string)
  -- <C-u> to eliminate the automatically inserted range in visual mode
  self[1] = (":<C-u>%s<CR>"):format(cmd_string)
  return self
end

---@param callback fun():nil
--- Takes a callback that will be called when the key is pressed
---@return map_rhs
function rhs_options:map_callback(callback)
  self[1] = callback
  return self
end

---@return map_rhs
function rhs_options:with_silent()
  self.silent = true
  return self
end

---@param description_string string
---@return map_rhs
function rhs_options:with_desc(description_string)
  self.desc = description_string
  return self
end

---@return map_rhs
function rhs_options:with_noremap()
  self.noremap = true
  return self
end

---@return map_rhs
function rhs_options:with_expr()
  self.expr = true
  return self
end

---@return map_rhs
function rhs_options:with_nowait()
  self.nowait = true
  return self
end

---@param num number
---@return map_rhs
function rhs_options:with_buffer(num)
  self.buffer = num
  return self
end

--! >>>>>>>>>>>>>> BINDING <<<<<<<<<<<<<< --

---@class AndromedaKeymapKit
local bind = Andromeda.kit.keymap

---@param cmd_string string
---@return map_rhs
function bind.map_cr(cmd_string)
  local ro = rhs_options:new()
  return ro:map_cr(cmd_string)
end

---@param cmd_string string
---@return map_rhs
function bind.map_cmd(cmd_string)
  local ro = rhs_options:new()
  return ro:map_cmd(cmd_string)
end

---@param cmd_string string
---@return map_rhs
function bind.map_cu(cmd_string)
  local ro = rhs_options:new()
  return ro:map_cu(cmd_string)
end

---@param cmd_string string
---@return map_rhs
function bind.map_args(cmd_string)
  local ro = rhs_options:new()
  return ro:map_args(cmd_string)
end

---@param callback fun():nil
---@return map_rhs
function bind.map_callback(callback)
  local ro = rhs_options:new()
  return ro:map_callback(callback)
end

--! >>>>>>>>>>>>>> Helpers <<<<<<<<<<<<<< --

---@param cmd_string string
---@return string escaped_string
function bind.escape_termcode(cmd_string) return vim.api.nvim_replace_termcodes(cmd_string, true, true, true) end

---@param mappings table
function bind.add_mappings(mappings)
  local astro_mappings = require("astrocore").plugin_opts("astrocore").mappings
  require("astrocore.init").set_mappings(table.extend(astro_mappings, mappings))
end
