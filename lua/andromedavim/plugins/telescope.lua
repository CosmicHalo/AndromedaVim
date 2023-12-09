local Lib = require "andromedavim.libs"
local andromeda = require "andromedacore"

local telescope_deps = {
  "nvim-telescope/telescope-fzf-native.nvim",
  build = "make",
  enabled = vim.fn.executable "make" == 1,
  config = function()
    andromeda.on_load("telescope.nvim", function() require("telescope").load_extension "fzf" end)
  end,
}

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = {
    telescope_deps,

    {
      "AndromedaVim/andromedacore",
      dev = true,
      opts = Lib.load_mappings "telescope",
    },
  },

  opts = function()
    local actions = require "telescope.actions"
    local get_icon = require("andromedaui").get_icon

    return {
      defaults = {
        git_worktrees = require("andromedacore").config.git_worktrees,

        prompt_prefix = get_icon("Selected", 1),
        selection_caret = get_icon("Selected", 1),

        path_display = { "truncate" },
        sorting_strategy = "ascending",

        layout_config = {
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
          vertical = { mirror = false },
          horizontal = { prompt_position = "top", preview_width = 0.55 },
        },

        mappings = {
          n = { q = actions.close },
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
    }
  end,
}
