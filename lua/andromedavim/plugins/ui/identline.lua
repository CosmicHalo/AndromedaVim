local cfg = Andromeda.configs.indentscope

local char = "╎"
local ignore_buftypes = cfg.ignore_buftypes
local ignore_filetypes = cfg.ignore_filetypes

return {
  "echasnovski/mini.indentscope",
  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    { "AstroNvim/astrocore", opts = cfg.config },

    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {
        indent = { char = char, tab_char = "." },
        scope = { enabled = true, show_exact_scope = true },
        exclude = { buftypes = ignore_buftypes, filetypes = ignore_filetypes },
      },
    },
  },

  opts = function()
    return {
      draw = { delay = 0, animation = function() return 0 end },
      options = { try_as_border = true },
      symbol = require("astrocore").plugin_opts("indent-blankline.nvim").context_char or char,
    }
  end,
}
