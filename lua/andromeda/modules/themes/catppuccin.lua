return {
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
      optional = true,
      opts = {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      },
    },
  },

  opts = {
    integrations = {
      aerial = true,
      alpha = true,
      cmp = true,
      leap = true,
      lsp_trouble = true,
      markdown = true,
      mason = true,
      mini = true,
      neotest = true,
      neotree = true,
      noice = true,
      notify = true,
      nvimtree = false,
      overseer = true,
      rainbow_delimiters = true,
      sandwich = false,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = true,
      ts_rainbow = false,
      which_key = true,

      dap = {
        enabled = true,
        enable_ui = true,
      },
    },
  },
  config = function(_, opts)
    -- Andromeda.kit.ui.activate_colorscheme("catppuccin", function() require("catppuccin").setup(opts) end, true)
  end,
}
