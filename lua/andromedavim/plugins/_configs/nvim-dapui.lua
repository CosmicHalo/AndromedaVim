Andromeda.mappings.dapui = function(_, opts)
  local maps = opts.mappings
  maps.n["<Leader>d"] = opts._map_section.d
  maps.n["<Leader>du"] = { function() require("dapui").toggle() end, desc = "Toggle Debugger UI" }
  maps.n["<Leader>dh"] = { function() require("dap.ui.widgets").hover() end, desc = "Debugger Hover" }
  maps.n["<Leader>dE"] = {
    function()
      vim.ui.input({ prompt = "Expression: " }, function(expr)
        if expr then
          local args = { enter = true }
          require("dapui").eval(expr, args)
        end
      end)
    end,
    desc = "Evaluate Input",
  }
end

Andromeda.configs.dapui = function(_, opts)
  local dap, dapui = require "dap", require "dapui"
  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
  dapui.setup(opts)
end
