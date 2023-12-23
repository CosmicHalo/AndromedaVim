local NOTE = "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"

return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = vim.fn.has("win32") == 0 and NOTE or nil,
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      region_check_events = "CursorMoved",
    },
    config = function(_, opts)
      if opts then require("luasnip").config.setup(opts) end
      vim.tbl_map(
        function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
        { "vscode", "snipmate", "lua" }
      )
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      Andromeda.kit.add_mappings({
        ["<Leader>uc"] = {
          function() require("astrocore.toggles").buffer_cmp() end,
          desc = "Toggle autocompletion (buffer)",
        },
        ["<Leader>uC"] = {
          function() require("astrocore.toggles").cmp() end,
          desc = "Toggle autocompletion (global)",
        },
      }),
    },
    opts = require("completion.nvim-cmp"),
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    dependencies = { { "hrsh7th/nvim-cmp", opts = require("completion.copilot")["nvim-cmp"] } },
    opts = {
      panel = { enabled = false },
      suggestion = { debounce = 150, auto_trigger = true },
      cmp = { enabled = true, method = "getCompletionsCycling" },

      filetypes = {
        -- help = true,
        -- markdown = true,
        ["dap-repl"] = false,
        ["big_file_disabled_ft"] = false,
      },
    },
  },
}
