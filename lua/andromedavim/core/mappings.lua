local get_icon = require("astroui").get_icon

local M = {}

M.noice = function(_, opts)
  local maps = opts.mappings
  local noice = require "noice"

  maps.n["<leader>n"] = { desc = get_icon("Sparkle", 1, true) .. "Noice" }
  maps.n["<leader>na"] = { function() noice.cmd "all" end, desc = "Noice All" }
  maps.n["<leader>nd"] = { function() noice.cmd "dismiss" end, desc = "Dismiss All" }
  maps.n["<leader>nh"] = { function() noice.cmd "history" end, desc = "Noice History" }
  maps.n["<leader>nl"] = { function() noice.cmd "last" end, desc = "Noice Last Message" }
end

return M
