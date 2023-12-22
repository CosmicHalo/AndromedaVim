---@class AndromedaSettings
local conf = {}

-- THEME CONFIGURATION
conf.theme = {
  -- Available themes:
  --   nightfox, tokyonight, dracula, kanagawa, catppuccin,
  --   tundra, onedarkpro, everforest, monokai-pro, onedark, fluoromachine
  -- A configuration file for each theme is in lua/themes/
  -- Use <F8> to step through themes
  enabled = "fluoromachine",
  enabled_themes = { "astrodark", "tokyonight", "catppuccin", "fluoromachine", "solarized-osaka" },
  -- Available styles are:
  --   kanagawa:    wave, dragon, lotus
  --   tokyonight:  night, storm, day, moon
  --   dracula:     blood, magic, soft, default
  --   fluoromachine: delta, retrowave, default
  --   catppuccin:  latte, frappe, macchiato, mocha, custom
  --   onedarkpro:  onedark, onelight, onedark_vivid, onedark_dark
  --   monokai-pro: classic, octagon, pro, machine, ristretto, spectrum
  --   nightfox:    carbonfox, dawnfox, dayfox, duskfox, nightfox, nordfox, terafox
  style = "retrowave",
  enable_transparent = true, -- enable transparency if the theme supports it
}

-- GLOBAL OPTIONS CONFIGURATION
conf.options = {
  mapleader = " ",
  maplocalleader = ",",

  confirm = true, -- confirm to save changes before exiting modified buffer
  cursorline = true, -- enable cursorline
  expandtab = true, -- use spaces instead of tabs
  grepprg = "rg --hidden --vimgrep --smart-case --", -- use rg instead of grep
  list = true, -- enable or disable listchars
  mouse = "nv", -- enable mouse see :h mouse
  number = true, -- set numbered lines
  relative_number = true, -- set relative numbered lines
  showtabline = 2, -- always show tabs; 0 never, 1 only if at least two tab pages, 2 always
  timeoutlen = 300, -- set statusline
}

-- GLOBAL UI CONFIGURATION
conf.ui = {
  float = {
    border = "double",
  },
}

-- ENABLE/DISABLE/SELECT PLUGINS
conf.plugins = {
  --
  --! AI plugins
  -- AI coding assistants - ChatGPT, Code Explain, Codeium, Copilot, NeoAI
  -- Enable Github Copilot if you have an account, it is superior
  --
  -- Enable ChatGPT (set OPENAI_API_KEY environment variable)
  enable_chatgpt = true,
  -- Enable Github Copilot
  enable_copilot = true,

  --! Coding plugins
  -- Enable coding plugins for diagnostics, debugging, and language servers
  enable_coding = true,

  --! Editor plugins
  -- File explorer tree plugin: neo-tree, nvim-tree, or none
  file_tree = "nvim-tree",

  --! UI plugins
  enable_toggleterm = true, -- enable toggleterm plugin
  -- Enable a dashboard, can be one of "alpha", "dash", "mini", or "none"
  dashboard = "dash",

  --! Telescope plugins
  -- enable greping in hidden files
  telescope_grep_hidden = true,
  -- Enable the telescope theme switcher plugin
  enable_telescope_themes = true,
  -- Enable treesitter code context
  enable_treesitter_context = true,
}

return conf
