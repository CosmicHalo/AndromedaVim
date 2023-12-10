return {
  {
    "NvChad/nvim-colorizer.lua",
    event = "User AndromedaFile",
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>uz"] = { "<Cmd>ColorizerToggle<CR>", desc = "Toggle color highlight" }
        end,
      },
    },
    opts = { user_default_options = { names = false } },
  },

  {
    -- Theme inspired by Atom
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function() vim.cmd.colorscheme "onedark" end,
  },

  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = { transparent = true },
  },

  -- >>>>>>>>>>>>>>>>>>>>>>>>>>>> UI  <<<<<<<<<<<<<<<<<<<<<<<<<<<< --

  {
    "AstroNvim/astroui",
    opts = {
      colorscheme = "solarized-osaka",
    },
  },
}
