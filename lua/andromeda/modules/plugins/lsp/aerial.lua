return {
  {
    "stevearc/aerial.nvim",
    event = "User AndromedaFile",
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
      local max_file = assert(require("astrocore").config.features.max_file)

      return {
        lazy_load = false,
        show_guides = true,
        close_on_select = true,
        highlight_on_jump = false,

        attach_mode = "global",
        disable_max_size = max_file.size,
        disable_max_lines = max_file.lines,
        backends = { "lsp", "treesitter", "markdown", "man" },
        ignore = { filetypes = { "NvimTree", "terminal", "nofile" } },
        layout = { min_width = 28, default_direction = "prefer_right" },

        -- Use symbol tree for folding. Set to true or false to enable/disable
        -- Set to "auto" to manage folds if your previous foldmethod was 'manual'
        -- This can be a filetype map (see :help aerial-filetype-map)
        manage_folds = "auto",

        guides = {
          mid_item = "├ ",
          last_item = "└ ",
          nested_top = "│ ",
          whitespace = "  ",
        },

        -- A list of all symbols to display. Set to false to display all symbols.
        -- This can be a filetype map (see :help aerial-filetype-map)
        -- To see all available values, see :help SymbolKind
        filter_kind = {
          "Array",
          "Boolean",
          "Class",
          "Constant",
          "Constructor",
          "Enum",
          "EnumMember",
          "Event",
          "Field",
          "File",
          "Function",
          "Interface",
          "Key",
          "Method",
          "Module",
          "Namespace",
          "Null",
          -- "Number",
          "Object",
          "Operator",
          "Package",
          -- "Property",
          -- "String",
          "Struct",
          -- "TypeParameter",
          -- "Variable",
        },

        keymaps = {
          ["?"] = "actions.show_help",
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.jump",
          ["<2-LeftMouse>"] = "actions.jump",
          ["<C-v>"] = "actions.jump_vsplit",
          ["<C-s>"] = "actions.jump_split",
          ["<C-d>"] = "actions.down_and_scroll",
          ["<C-u>"] = "actions.up_and_scroll",
          ["{"] = "actions.prev",
          ["}"] = "actions.next",
          ["[["] = "actions.prev_up",
          ["]]"] = "actions.next_up",
          ["q"] = "actions.close",
          ["o"] = "actions.tree_toggle",
          ["O"] = "actions.tree_toggle_recursive",
          ["zr"] = "actions.tree_increase_fold_level",
          ["zR"] = "actions.tree_open_all",
          ["zm"] = "actions.tree_decrease_fold_level",
          ["zM"] = "actions.tree_close_all",
          ["zx"] = "actions.tree_sync_folds",
          ["zX"] = "actions.tree_sync_folds",
        },
      }
    end,
  },
}
