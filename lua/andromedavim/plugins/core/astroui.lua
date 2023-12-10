return {
  "AstroNvim/astroui",
  lazy = true,
  ---@type AstroUIOpts
  opts = {
    icons = require "andromedavim.icons",
    text_icons = require "andromedavim.icons.text",
    colorscheme = require("andromedavim.core").default_colorscheme,
  },
}
