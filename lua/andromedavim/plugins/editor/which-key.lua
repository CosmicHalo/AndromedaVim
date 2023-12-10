return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    disable = { filetypes = { "TelescopePrompt" } },
    icons = { group = vim.g.icons_enabled ~= false and "" or "+", separator = "" },
  },
}
