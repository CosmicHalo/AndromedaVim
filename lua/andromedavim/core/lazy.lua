local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local icons = Andromeda.icons
local ui_sep = Andromeda.icons.ui.get

require("lazy")--[[@as Lazy]]
  .setup({
    spec = "andromedavim.plugins",

    checker = { enabled = true },
    change_detection = { enabled = true },
    defaults = { lazy = true, version = false },
    install = { missing = true, colorscheme = { "onedark", "astrodark", "catppuccin-mocha", "solarized-osaka" } },

    ---@diagnostic disable-next-line: assign-type-mismatch
    dev = {
      fallback = false,
      patterns = { "AndromedaVim" },
      path = "~/.config/kickstart/localplugins",
    },

    ui = {
      wrap = true, -- wrap the lines in the ui
      -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
      border = "double",

      icons = {
        cmd = icons.misc.Code,
        start = icons.ui.Play,
        config = icons.ui.Gear,
        init = icons.misc.ManUp,
        loaded = icons.ui.Check,
        event = icons.kind.Event,
        keys = icons.ui.Keyboard,
        runtime = icons.misc.Vim,
        plugin = icons.ui.Package,
        ft = icons.documents.Files,
        not_loaded = icons.misc.Ghost,
        import = icons.documents.Import,
        source = icons.kind.StaticMethod,
        list = { ui_sep("Square"), ui_sep("BigCircle"), ui_sep("ChevronRight"), ui_sep("BigUnfilledCircle") },
      },
    },

    performance = {
      rtp = {
        -- disable some rtp plugins
        disabled_plugins = {
          "gzip",
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  })
