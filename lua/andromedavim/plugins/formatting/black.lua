return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts) table.insert(opts.ensure_installed, "black") end,
  },

  {
    "rshkarin/mason-nvim-lint",
    opts = function(_, opts) require("andromedavim.libs").extend_opt(opts, { "black" }) end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["python"] = { "black" },
      },
    },
  },
}
