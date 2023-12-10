local cfg = Andromeda.load_config "dashboard"

local hypr_cfg = cfg.hypr
local doom_cfg = cfg.doom

return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = require("andromedavim.core").default_dashboard == "hyper" and hypr_cfg or doom_cfg,
  },
}
