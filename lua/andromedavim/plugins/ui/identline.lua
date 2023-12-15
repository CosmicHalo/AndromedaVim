local cfg = Andromeda.configs.indentscope

local char = "╎"
local ignore_buftypes = cfg.ignore_buftypes
local ignore_filetypes = cfg.ignore_filetypes

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      enabled = true,
      debounce = 200,
      whitespace = { remove_blankline_trail = true },

      indent = {
        char = char,
        priority = 2,
        tab_char = char,
        smart_indent_cap = true,
      },

      exclude = {
        buftypes = ignore_buftypes,
        filetypes = ignore_filetypes,
      },

      -- Note: The `scope` field requires treesitter to be set up
      scope = {
        -- priority = 2,
        char = char,
        enabled = true,
        priority = 1000,
        show_end = true,
        show_start = true,
        -- show_exact_scope = true,
        smart_indent_cap = true,
        injected_languages = true,

        include = {
          node_type = {
            ["*"] = {
              "argument_list",
              "arguments",
              "assignment_statement",
              "Block",
              "class",
              "ContainerDecl",
              "dictionary",
              "do_block",
              "do_statement",
              "element",
              "except",
              "FnCallArguments",
              "for",
              "for_statement",
              "function",
              "function_declaration",
              "function_definition",
              "if_statement",
              "IfExpr",
              "IfStatement",
              "import",
              "InitList",
              "list_literal",
              "method",
              "object",
              "ParamDeclList",
              "repeat_statement",
              "selector",
              "SwitchExpr",
              "table",
              "table_constructor",
              "try",
              "tuple",
              "type",
              "var",
              "while",
              "while_statement",
              "with",
            },
          },
        },
      },
    },
  },

  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { { "AstroNvim/astrocore", opts = cfg.config } },
    opts = function()
      return {
        draw = { delay = 0, animation = function() return 0 end },
        options = { try_as_border = true },
        symbol = require("astrocore").plugin_opts("indent-blankline.nvim").context_char or char,
      }
    end,
  },
}
