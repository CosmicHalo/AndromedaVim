return {
  "windwp/nvim-autopairs",
  event = "User AndromedaFile",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>ua"] = { function() require("astrocore.toggles").autopairs() end, desc = "Toggle autopairs" }
      end,
    },
  },
  opts = {
    check_ts = true,
    ts_config = { java = false },
    fast_wrap = {
      offset = 0,
      map = "<M-e>",
      end_key = "$",
      check_comma = true,
      highlight = "PmenuSel",
      highlight_grey = "LineNr",
      chars = { "{", "[", "(", '"', "'" },
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    },
  },
  config = function(_, opts)
    local npairs = require "nvim-autopairs"
    npairs.setup(opts)

    local astrocore = require "astrocore"
    if not astrocore.config.features.autopairs then npairs.disable() end

    astrocore.on_load(
      "nvim-cmp",
      function()
        require("cmp").event:on(
          "confirm_done",
          require("nvim-autopairs.completion.cmp").on_confirm_done { tex = false }
        )
      end
    )
  end,
}
