return {
  {
    "stevearc/aerial.nvim",
    event = "User AstroFile",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>lS"] = { function() require("aerial").toggle() end, desc = "Symbols outline" }
        end,
      },
    },
    opts = function()
      local max_file = require("astrocore").config.features.max_file --[[@as AstroCoreMaxFile]]

      return {
        show_guides = true,
        filter_kind = false,
        attach_mode = "global",
        layout = { min_width = 28 },
        disable_max_size = max_file.size,
        disable_max_lines = max_file.lines,
        backends = { "lsp", "treesitter", "markdown", "man" },

        guides = {
          mid_item = "├ ",
          last_item = "└ ",
          nested_top = "│ ",
          whitespace = "  ",
        },

        keymaps = {
          ["{"] = false,
          ["}"] = false,
          ["[["] = false,
          ["]]"] = false,
          ["[y"] = "actions.prev",
          ["]y"] = "actions.next",
          ["[Y"] = "actions.prev_up",
          ["]Y"] = "actions.next_up",
        },
      }
    end,
  },
}
