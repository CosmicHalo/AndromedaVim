return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "black" }) end,
  },
}
