local M = {}

M.hypr = function()
  local get_icon = function(icon) return require("astroui").get_icon(icon, 1, true) end

  local opts = {
    theme = "hyper", --  theme is doom and hyper default is hyper
    disable_move = false, --  defualt is false disable move keymap for hyper
    shortcut_type = "letter", --  shorcut type 'letter' or 'number'
    change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs

    hide = {
      winbar = false, -- hide winbar
      tabline = false, -- hide the tabline
      statusline = true, -- hide statusline default is true
    },

    config = {
      week_header = {
        enable = true,
        append = { "", get_icon "Circle" .. " Nvim2K: Learn. Make, Explore! " .. get_icon "Circle" },
      },

      mru = { limit = 8 },
      packages = { enable = true }, -- show how many plugins neovim loaded
      project = { enable = true, limit = 8 },

      -- stylua: ignore
      shortcut = {
        { action = 'Telescope find_files',  desc = get_icon "OpenFolder" .. "Files",    group = "Label",  key = "f" },
        { action = 'Telescope live_grep',   desc = get_icon "Search" .. "Search",       group = "Label",  key = "g" },
        { action = "Telescope oldfiles",    desc = get_icon "Search" .. "Recent files", group = "Label",  key = "r" },
        
        { action = "Telekasten goto_today", desc = get_icon "Note" .. "Notes",  group = "Label",      key = "n" },
        { action = "Lazy", desc = get_icon "Package" .. "Plugins",              group = "@property",  key = "l" },
        { action = "quit", desc = get_icon "Power",                             group = "Action",     key = "q" },
      },

      footer = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return {
          "",
          get_icon "Heart" .. " Happiness is a state of mind. " .. "Heart",
        }
      end,
    },
  }

  -- close Lazy and re-open when the dashboard is ready
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      pattern = "DashboardLoaded",
      callback = function() require("lazy").show() end,
    })
  end

  return opts
end

M.doom = function()
  local TelescopeLib = require "andromedavim.libs.telescope"

  local get_icon = function(icon) return require("astroui").get_icon(icon, 1, true) end
  local function wrap_text(text, icon) return icon .. " " .. text .. " " .. icon end

  local opts = {
    theme = "doom",
    hide = { statusline = true },

    config = {
      week_header = {
        enable = true,
        append = { "", wrap_text("AndromedaVim: Explore the Universe!", get_icon "LazyInit") },
      },

      -- stylua: ignore
      center = {
        { action = "ene | startinsert",                                             desc = " New file",     icon = get_icon ("File"),      key = "n" },
        { action = "Telescope find_files",                                          desc = " Find file",    icon = get_icon ("Search"),    key = "f" },
        { action = "Telescope oldfiles",                                            desc = " Recent files", icon = get_icon ("Files"),     key = "r" },
        { action = "Telescope live_grep",                                           desc = " Find text",    icon = get_icon ("Keyboard"),  key = "g" },
        { action = [[lua require("andromedavim.libs").telescope.config_files()()]], desc = " Config",       icon = get_icon ("Gear"),      key = "c" },
        { action = "Lazy",                                                          desc = " Lazy",         icon = get_icon ("Lazy"),      key = "l" },
        { action = "qa",                                                            desc = " Quit",         icon = get_icon ("Power"),     key = "q" },
      },

      footer = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return {
          wrap_text("Happiness is a state of mind.", get_icon "LazyInit"),
          "",
          wrap_text("Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms", "⚡"),
        }
      end,
    },
  }

  for _, button in ipairs(opts.config.center) do
    button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
    button.key_format = "  %s"
  end

  -- close Lazy and re-open when the dashboard is ready
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      pattern = "DashboardLoaded",
      callback = function() require("lazy").show() end,
    })
  end

  return opts
end

return M
