return {
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function() require("astrocore").load_plugin_with_func("dressing.nvim", vim.ui, { "input", "select" }) end,
    opts = {
      input = { default_prompt = "➤ " },
      select = { backend = { "telescope", "builtin" } },
    },
  },

  {
    "onsails/lspkind.nvim",
    lazy = true,
    enabled = vim.g.icons_enabled ~= false,
    opts = {
      menu = {},
      mode = "symbol",
      symbol_map = {
        Array = "󰅪",
        Boolean = "⊨",
        Class = "󰌗",
        Constructor = "",
        Key = "󰌆",
        Namespace = "󰅪",
        Null = "NULL",
        Number = "#",
        Object = "󰀚",
        Package = "󰏗",
        Property = "",
        Reference = "",
        Snippet = "",
        String = "󰀬",
        TypeParameter = "󰊄",
        Unit = "",
      },
    },
    config = function(_, opts) require("lspkind").init(opts) end,
  },

  {
    "edluffy/specs.nvim",
    lazy = true,
    event = "CursorMoved",
    opts = function()
      return {
        min_jump = 10,
        show_jumps = true,

        ignore_filetypes = {},
        ignore_buftypes = { nofile = true },

        popup = {
          delay_ms = 0, -- delay before popup displays
          inc_ms = 10, -- time increments used for fade/resize effects
          blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
          width = 10,
          winhl = "PmenuSbar",
          fader = require("specs").pulse_fader,
          resizer = require("specs").shrink_resizer,
        },
      }
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    enabled = vim.g.icons_enabled ~= false,
    opts = function()
      return {
        override = {
          xz = { icon = "", name = "Xz" },
          deb = { icon = "", name = "Deb" },
          mp3 = { icon = "󰎆", name = "Mp3" },
          mp4 = { icon = "", name = "Mp4" },
          out = { icon = "", name = "Out" },
          rpm = { icon = "", name = "Rpm" },
          zip = { icon = "", name = "Zip" },
          lock = { icon = "󰌾", name = "Lock" },
          ttf = { icon = "", name = "TrueTypeFont" },
          ["robots.txt"] = { icon = "󰚩", name = "Robots" },
          woff = { icon = "", name = "WebOpenFontFormat" },
          woff2 = { icon = "", name = "WebOpenFontFormat2" },
          default_icon = { icon = Andromeda.icons.documents.File },
        },
      }
    end,
  },
}
