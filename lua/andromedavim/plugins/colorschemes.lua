return {
  {
    "NvChad/nvim-colorizer.lua",
    event = "User AndromedaFile",
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>uz"] = { "<Cmd>ColorizerToggle<CR>", desc = "Toggle color highlight" }
        end,
      },
    },
    opts = { user_default_options = { names = false } },
  },

  -- {
  --   "lvim-tech/lvim-colorscheme",
  --   priority = 100,
  --   opts = {
  --     style = "dark", -- dark, darksoft, light
  --     -- default = "lvim-gruvbox-dark",
  --     -- default = "lvim-catppuccin-dark",

  --     styles = {
  --       variables = {},
  --       comments = { italic = true, bold = true },
  --       keywords = { italic = true, bold = true },
  --       functions = { italic = true, bold = true },
  --     },

  --     colors = {
  --       dark = {},
  --       light = {},
  --       darksoft = {},
  --     },

  --     sidebars = {
  --       "qf",
  --       "pqf",
  --       "dbui",
  --       "packer",
  --       "Outline",
  --       "terminal",
  --       "calendar",
  --       "neo-tree",
  --       "ctrlspace",
  --       "spectre_panel",
  --     },
  --   },
  -- },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      integrations = {
        sandwich = false,
        noice = true,
        mini = true,
        leap = true,
        markdown = true,
        neotest = true,
        cmp = true,
        overseer = true,
        lsp_trouble = true,
        rainbow_delimiters = true,
      },
    },
  },

  {
    -- Theme inspired by Atom
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      term_colors = true, -- Change terminal color as per the selected theme style
      transparent = true, -- Show/hide background
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
    },
  },

  {
    "craftzdog/solarized-osaka.nvim",
    priority = 1000,
    opts = { transparent = true },
  },

  {
    "maxmx03/fluoromachine.nvim",
    config = function()
      local fm = require("fluoromachine")
      local options = { "fluoromachine", "retrowave", "delta" }

      fm.setup({
        glow = true,
        theme = "retrowave",
        transparent = true,
      })
    end,
  },

  -- >>>>>>>>>>>>>>>>>>>>>>>>>>>> UI  <<<<<<<<<<<<<<<<<<<<<<<<<<<< --

  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function(_, opts)
      require("themery").setup({
        themeConfigFile = "/home/n16hth4wk/.config/nvim/settings/theme.lua",
        themes = { "astrodark", "catppuccin", "lvim", "onedark", "fluoromachine", "solarized-osaka" },
      })
    end,
  },

  {
    "AstroNvim/astroui",
    lazy = true,
    ---@type AstroUIOpts
    opts = {
      colorscheme = "fluoromachine",
    },
  },
}
