local astro = require("astrocore")
local function add_extension(plugin, extension)
  return { plugin, config = function() Andromeda.kit.telescope.load_extension(extension) end }
end

local telescope_deps = {
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  add_extension("debugloop/telescope-undo.nvim", "undo"),
  add_extension("jvgrootveld/telescope-zoxide", "zoxide"),
  add_extension("crispgm/telescope-heading.nvim", "heading"),
  add_extension("nvim-telescope/telescope-fzf-native.nvim", "fzf"),
  add_extension("nvim-telescope/telescope-frecency.nvim", "frecency"),
  add_extension("nvim-telescope/telescope-file-browser.nvim", "file_browser"),
  add_extension("nvim-telescope/telescope-live-grep-args.nvim", "live_grep_args"),
}

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = { telescope_deps, { "AstroNvim/astrocore", opts = require("mappings.telescope") } },

  opts = function()
    local actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")

    local icons = {
      ui = Andromeda.icons.ui.get_wrapped,
    }

    return {
      defaults = {
        -- results_title = true,
        color_devicons = true,

        initial_mode = "insert",
        scroll_strategy = "limit",
        path_display = { "absolute" },

        selection_strategy = "reset",
        sorting_strategy = "ascending",
        -- layout_strategy = "horizontal",

        prompt_prefix = icons.ui("Telescope"),
        git_worktrees = astro.config.git_worktrees,
        selection_caret = Andromeda.icons.ui.ChevronRight,

        vimgrep_arguments = {
          "rg",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },

        file_ignore_patterns = {
          ".git/",
          ".cache",
          "build/",
          "%.class",
          "%.pdf",
          "%.mkv",
          "%.mp4",
          "%.zip",
        },

        layout_config = {
          width = 0.85,
          height = 0.92,
          preview_cutoff = 120,
          vertical = { mirror = false },
          horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
        },

        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,

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

      extensions = {
        aerial = {
          show_lines = false,
          show_nesting = {
            ["_"] = false, -- This key will be the default
            lua = true, -- You can set the option for specific filetypes
          },
        },

        fzf = {
          fuzzy = false,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },

        frecency = {
          use_sqlite = false,
          show_scores = true,
          show_unindexed = true,
          ignore_patterns = { "*.git/*", "*/tmp/*" },
        },

        -- live_grep_args = {
        --   auto_quoting = true, -- enable/disable auto-quoting
        --   -- define mappings, e.g.
        --   mappings = { -- extend mappings
        --     i = {
        --       ["<C-k>"] = lga_actions.quote_prompt(),
        --       ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        --     },
        --   },
        -- },

        undo = {
          side_by_side = true,
          mappings = { -- this whole table is the default
            i = {
              -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
              -- you want to use the following actions. This means installing as a dependency of
              -- telescope in it's `requirements` and loading this extension from there instead of
              -- having the separate plugin definition as outlined above. See issue #6.
              ["<C-cr>"] = require("telescope-undo.actions").restore,
              ["<cr>"] = require("telescope-undo.actions").yank_additions,
              ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
            },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope") --[[@as Telescope]]
    telescope.setup(opts)
    telescope.load_extension("notify")
    telescope.load_extension("aerial")
  end,
}
