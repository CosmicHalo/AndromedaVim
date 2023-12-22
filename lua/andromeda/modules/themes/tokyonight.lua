local settings = Andromeda.settings

local function set_colorscheme(sty)
  local have_current = false
  if settings.enable_telescope_themes then
    local theme_ok, _ = pcall(require, "current-theme")
    if theme_ok then have_current = true end
  end

  if have_current then
    require("current-theme")
  else
    local theme = ""

    if sty == "night" then
      theme = "tokyonight-night"
    elseif sty == "moon" then
      theme = "tokyonight-moon"
    elseif sty == "storm" then
      theme = "tokyonight-storm"
    elseif sty == "day" then
      vim.opt.background = "light"
      theme = "tokyonight-day"
    else
      theme = "tokyonight"
    end

    Andromeda.kit.ui.set_colorscheme(theme)
  end
end

--- You can override specific color groups to use other groups or a hex color
--- function will be called with a ColorScheme table
--- on_colors = function(colors) end,

--- You can override specific highlights to use other groups or a hex color
--- function will be called with a Highlights and ColorScheme table
--- on_highlights = function(highlights, colors) end,

local sidebars = "dark"
if settings.theme.enable_transparent then sidebars = "transparent" end

return {
  opts = {
    -- `storm`, `moon`, a darker variant `night` and `day`
    style = settings.theme.style,
    transparent = settings.theme.enable_transparent,

    light_style = "day", -- The theme is used when the background is set to light
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim

    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.

    styles = {
      functions = {},
      variables = {},

      -- Background styles. Can be "dark", "transparent" or "normal"
      floats = "dark", -- style for floating windows
      sidebars = sidebars, -- style for sidebars, see below

      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
    },

    sidebars = {
      "qf",
      "help",
      "Outline",
      "terminal",
      "vista_kind",
      "startuptime",
      "spectre_panel",
    },
  },
  config = function()
    Andromeda.kit.ui.activate_colorscheme("tokyonight", function()
      vim.opt.background = "dark"
      set_colorscheme(settings.theme.style)

      vim.api.nvim_set_hl(0, "MiniJump", { fg = "#FFFFFF", bg = "#ff00a0" })
      vim.g.tokyonight_transparent = require("tokyonight.config").options.transparent

      -- Andromeda.kits.map("n", "<leader>ut", function()
      --   vim.g.tokyonight_transparent = not vim.g.tokyonight_transparent

      --   local sidebar = "dark"
      --   if vim.g.tokyonight_transparent then sidebar = "transparent" end

      --   require("tokyonight").setup({
      --     transparent = vim.g.tokyonight_transparent,
      --     styles = {
      --       comments = { italic = true },
      --       keywords = { italic = true },
      --       functions = {},
      --       variables = {},
      --       sidebars = sidebar,
      --       floats = "dark",
      --     },
      --   })

      --   set_colorscheme(settings.theme.style)
      -- end, { desc = "Toggle Transparency" })
    end)
  end,
}
