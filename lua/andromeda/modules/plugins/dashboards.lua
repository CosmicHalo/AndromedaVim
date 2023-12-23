local settings = Andromeda.settings.plugins

local DASHBOARDS = {
  none = "none",
  mini = "mini",
  dashboard = "dash",
}

local dashboard_depend = { "nvim-tree/nvim-web-devicons" }
if settings.enable_toggleterm then
  dashboard_depend = {
    "akinsho/toggleterm.nvim",
    "nvim-tree/nvim-web-devicons",
  }
end

local dash = {}

if settings.dashboard == DASHBOARDS.dashboard then
  dash = {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = dashboard_depend,
    opts = require("dashboards.dashboard-nvim"),
  }
elseif settings.dashboard == DASHBOARDS.mini then
  dash = {
    "echasnovski/mini.starter",
    version = false,
    event = "VimEnter",
    dependencies = dashboard_depend,
    config = require("dashboards.mini"),
  }
end

return dash
