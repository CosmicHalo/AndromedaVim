local M = {}

M.noice = function(_, opts)
  local maps = opts.mappings
  local noice = require "noice"

  maps.n["<leader>s"] = { desc = "Noice" }
  maps.n["<leader>sna"] = { function() noice.cmd "all" end, desc = "Noice All" }
  maps.n["<leader>snd"] = { function() noice.cmd "dismiss" end, desc = "Dismiss All" }
  maps.n["<leader>snh"] = { function() noice.cmd "history" end, desc = "Noice History" }
  maps.n["<leader>snl"] = { function() noice.cmd "last" end, desc = "Noice Last Message" }
end

return M
