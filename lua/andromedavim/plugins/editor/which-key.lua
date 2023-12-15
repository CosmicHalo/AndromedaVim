local icons = {
  ui = Andromeda.icons.ui,
  misc = Andromeda.icons.misc,
}

return {
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
}
