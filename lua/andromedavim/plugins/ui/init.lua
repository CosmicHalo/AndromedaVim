return {
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
          default_icon = { icon = require("astroui").get_icon("DefaultFile") },
        },
      }
    end,
  },
}
