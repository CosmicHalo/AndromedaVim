return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "ocaml" }) end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "ocaml-lsp", "ocamlformat" }) end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ocamllsp = { codelens = { enable = true } },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["ocaml"] = { "ocamlformat" },
      },
    },
  },
}
