local Lib = require "andromedavim.libs"

local M = {}

M.init = function()
  -- Install the conform formatter on VeryLazy
  Lib.on_very_lazy(function()
    Lib.format.register {
      priority = 100,
      primary = true,
      name = "conform.nvim",

      format = function(buf)
        local plugin = require("lazy.core.config").plugins["conform.nvim"]
        local Plugin = require "lazy.core.plugin"
        local opts = Plugin.values(plugin, "opts", false)
        require("conform").format(Lib.merge(opts.format, { bufnr = buf }))
      end,

      sources = function(buf)
        local ret = require("conform").list_formatters(buf)
        ---@param v conform.FormatterInfo
        return vim.tbl_map(function(v) return v.name end, ret)
      end,
    }
  end)
end

M.mappings = function(_, opts)
  -- local maps = opts.mappings
  -- maps.n["<leader>cF"] = {
  --   function() require("conform").format { formatters = { "injected" } } end,
  --   desc = "Format Injected Langs",
  -- }
end

return M
