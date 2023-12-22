local function req(module)
  local status_ok, fault = pcall(require, module)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. module .. "\n\n" .. fault) end
end

local function load(modules, prefix)
  for _, module in ipairs(modules) do
    req((prefix and prefix .. "." or "") .. module)
  end
end

-- Enables the experimental Lua module loader
vim.loader.enable()

local modules = { "lua_extensions" }
local core_modules = { "Globals", "Andromeda", "options", "lazy" }

-- Load regular modules
load(modules)
-- Load core modules
load(core_modules, "andromedavim.core")
