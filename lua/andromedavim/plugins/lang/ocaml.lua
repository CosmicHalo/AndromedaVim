return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "ocaml" }) end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "ocamllsp" }) end,
  },

  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      Andromeda.lib.extend_list_opt(opts, { "ocamllsp" }, "servers")
      opts.config = Andromeda.lib.extend_tbl(opts.config or {}, {
        ocamllsp = { codelens = { enable = true } },
      })
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, { nls.builtins.formatting.ocamlformat })
    end,
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
