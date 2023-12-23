local motion = {}

motion = table.extend(motion, {
  {
    -- Flash enhances the built-in search functionality by showing labels
    -- at the end of each match, letting you quickly jump to a specific
    -- location.
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      vscode = true,
      dependencies = {
        -- Flash Telescope config
        {
          optional = true,
          "nvim-telescope/telescope.nvim",
          opts = require("motion.flash").telescope,
        },
      },
      ---@type Flash.Config
      opts = {

        label = {
          -- allow uppercase labels
          uppercase = true,
          -- add a label for the first match in the current window.
          -- you can always jump to the first match with `<CR>`
          current = true,
          -- for the current window, label targets closer to the cursor first
          distance = true,
        },

        modes = {
          search = { enabled = false },

          -- options used when flash is activated through
          -- `f`, `F`, `t`, `T`, `;` and `,` motions
          char = {
            enabled = true,
            -- hide after jump when not using jump labels
            autohide = false,
            -- show jump labels
            jump_labels = false,
            -- set to `false` to use the current line only
            multi_line = true,
            -- When using jump labels, don't use these keys
            -- This allows using those keys directly after the motion
            label = { exclude = "hjkliardc" },
          },
        },
      },
      keys = {
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      },
    },
  },
})
return motion
