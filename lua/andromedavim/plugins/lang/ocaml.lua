return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then vim.list_extend(opts.ensure_installed, { "ocaml" }) end
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts) require("andromedavim.libs").extend_list_opt(opts, { "ocaml-lsp", "ocamlformat" }) end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        neocmake = {},
      },
    },
  },

  {
    "AstroNvim/astrolsp",
    -- opts = function(_, opts)
    --   opts.servers = require("andromedavim.libs").extend_list_opt(opts, { "ocamllsp" }, "servers")
    --   opts.config = require("andromedavim.libs").extend_opts(opts.config, {
    --     ocamllsp = { codelens = { enable = true } },
    --   })

    --   Andromeda.debug(opts.servers)
    -- end,
    opts = function(_, opts) opts.servers = vim.list_extend(opts.servers, { "ocamllsp" }) end,
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
