return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts) require("andromedavim.libs").extend_list_opt(opts, { "prettier" }) end,
  },

  -- {
  --   "rshkarin/mason-nvim-lint",
  --   opts = function(_, opts) require("andromedavim.libs").extend_list_opt(opts.ensure_installed, { "prettier" }) end,
  -- },
}
