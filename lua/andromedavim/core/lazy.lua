local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

local icons = require "andromedavim.icons"

require("lazy").setup {
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
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "double",

    icons = {
      ft = icons.File,
      lazy = icons.Lazy,
      task = icons.Check,
      config = icons.Gear,
      event = icons.Event,
      cmd = icons.Terminal,
      init = icons.LazyInit,
      keys = icons.Keyboard,
      plugin = icons.Package,
      runtime = icons.NeoVim,
      start = icons.LazyStart,
      import = icons.FileImport,
      source = icons.SourceCode,
      require = icons.LazyRequire,
      loaded = icons.PackageLoaded,
      not_loaded = icons.PackageUninstalled,
      list = { "●", "➜", "★", "‒" },
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
}
