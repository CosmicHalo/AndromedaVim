return {
  {
    -- Flash enhances the built-in search functionality by showing labels
    -- at the end of each match, letting you quickly jump to a specific
    -- location.
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      vscode = true,
      opts = require("motion.flash").flash,

      dependencies = {
        { "nvim-telescope/telescope.nvim", opts = require("motion.flash").telescope, optional = true },
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

  {
    "echasnovski/mini.ai",
    opts = function()
      local ai = require("mini.ai")

      return {
        n_lines = 500,
        custom_textobjects = {
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
        },
      }
    end,
    config = function(opts)
      require("mini.ai").setup(opts)
      require("astrocore")--[[@as astrocore]]
        .on_load("which-key.nvim", function()
          ---@type table<string, string|table>
          local i = {
            [" "] = "Whitespace",
            ['"'] = 'Balanced "',
            ["'"] = "Balanced '",
            ["`"] = "Balanced `",
            ["("] = "Balanced (",
            [")"] = "Balanced ) including white-space",
            [">"] = "Balanced > including white-space",
            ["<lt>"] = "Balanced <",
            ["]"] = "Balanced ] including white-space",
            ["["] = "Balanced [",
            ["}"] = "Balanced } including white-space",
            ["{"] = "Balanced {",
            ["?"] = "User Prompt",
            _ = "Underscore",
            a = "Argument",
            b = "Balanced ), ], }",
            c = "Class",
            f = "Function",
            o = "Block, conditional, loop",
            q = "Quote `, \", '",
            t = "Tag",
          }
          local a = vim.deepcopy(i)
          for k, v in pairs(a) do
            a[k] = v:gsub(" including.*", "")
          end

          local ic = vim.deepcopy(i)
          local ac = vim.deepcopy(a)
          for key, name in pairs({ n = "Next", l = "Last" }) do
            i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
            a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
          end
          require("which-key").register({
            mode = { "o", "x" },
            i = i,
            a = a,
          })
        end)
    end,
  },
}
