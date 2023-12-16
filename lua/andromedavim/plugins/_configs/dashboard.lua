local icons = {
  ui = Andromeda.icons.ui.get,
  kind = Andromeda.icons.kind.get,
  misc = Andromeda.icons.misc.get,
  file = Andromeda.icons.documents.get,
}

Andromeda.configs.dashboard = function()
  local function wrap_text(text, icon) return icon .. " " .. text .. " " .. icon end

  local opts = {
    theme = "doom",
    hide = { statusline = true },

    config = {
      week_header = {
        enable = true,
        append = { "", wrap_text("AndromedaVim: Explore the Universe!", icons.misc("Rocket", 1, true)) },
      },

      -- stylua: ignore
      center = {
        { action = "ene | startinsert",                     desc = " New file",     icon = icons.file("File"),    key = "n" },
        { action = "Telescope find_files",                  desc = " Find file",    icon = icons.ui("Search"),    key = "f" },
        { action = "Telescope oldfiles",                    desc = " Recent files", icon = icons.file("Files"),   key = "r" },
        { action = "Telescope live_grep",                   desc = " Find text",    icon = icons.ui("Keyboard"),  key = "g" },
        { action = Andromeda.lib.telescope.config_files(),  desc = " Config",       icon = icons.ui("Gear"),      key = "c" },
        { action = "Lazy",                                  desc = " Lazy",         icon = icons.misc("Lazy"),    key = "l" },
        { action = "qa",                                    desc = " Quit",         icon = icons.misc("Power"),   key = "q" },
      },

      footer = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return {
          wrap_text("Neovim version " .. Andromeda.lib.get_nvim_version(), icons.misc("Neovim")),
          "",
          wrap_text("Happiness is a state of mind.", icons.misc("Tree")),
          "",
          wrap_text(
            "Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
            icons.kind("Event", 1, true)
          ),
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
