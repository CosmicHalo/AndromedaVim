return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "User AstroFile",
    dependencies = "nvim-treesitter/nvim-treesitter",
    main = "rainbow-delimiters.setup",
  },

  {
    "catppuccin/nvim",
    optional = true,
    opts = { integrations = { rainbow_delimiters = true } },
  },
}
