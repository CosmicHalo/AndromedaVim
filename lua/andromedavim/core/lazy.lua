local vim_path = Globals.vim_path
local data_dir = Globals.data_dir
local modules_dir = vim_path .. "/lua/modules"
local lazy_path = data_dir .. "lazy/lazy.nvim"
local plugin_dir = modules_dir .. "/plugins/*.lua"

local Lazy = {}

function Lazy:append_nativertp()
  package.path = package.path
    .. string.format(
      ";%s;%s;%s;",
      modules_dir .. "/?.lua",
      modules_dir .. "/?/init.lua",
      modules_dir .. "/configs/?.lua",
      modules_dir .. "/configs/?/init.lua"
    )
end

function Lazy:init_lazy()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazypath) then
    vim.g.astronvim_first_install = true -- lets AstroNvim know that this is an initial installation
    -- stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  end

  ---@diagnostic disable-next-line: param-type-mismatch
  vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
end

function Lazy:load_lazy()
  self:init_lazy()

  local icons = Andromeda.icons
  local ui_sep = Andromeda.icons.ui.get

  ---@class LazyConfig
  local lazy_opts = {
    spec = { { import = "andromedavim.modules.plugins" } },

    checker = { enabled = true },
    change_detection = { enabled = true },
    defaults = { lazy = true, version = false },
    install = { missing = true, colorscheme = { "onedark", "astrodark", "catppuccin-mocha", "solarized-osaka" } },

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

        list = {
          ui_sep("Square"),
          ui_sep("BigCircle"),
          ui_sep("ChevronRight"),
          ui_sep("BigUnfilledCircle"),
        },
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

  if Globals.is_mac then lazy_opts.concurrency = 20 end

  require("lazy")--[[@as Lazy]]
    .setup(lazy_opts)
end

Lazy:load_lazy()
