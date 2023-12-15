local icons = {
  ui = Andromeda.icons.ui,
  misc = Andromeda.icons.misc,
}

return {
  {
    "lambdalisue/suda.vim",
    lazy = true,
    cmd = { "SudaRead", "SudaWrite" },
    opts = {},
    config = function(_, opts)
      vim.g["suda#prompt"] = "Enter administrator password: "
      require("suda").setup(opts)
    end,
  },

  -- {
  --   "folke/twilight.nvim",
  --   dependencies = {
  --     {
  --       "AstroNvim/astrocore",
  --       opts = {
  --         mappings = {
  --           ["<Leader>uT"] = { "<CMD>Twilight<CR>", desc = "Toggle Twilight" },
  --         },
  --       },
  --     },
  --   },
  -- },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      disable = { filetypes = { "TelescopePrompt" } },

      icons = {
        group = icons.misc.Add,
        separator = icons.misc.Vbar,
        breadcrumb = icons.ui.Separator,
      },

      window = {
        winblend = 0,
        border = "double",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 1, 1, 1, 1 },
      },
    },
  },
}
