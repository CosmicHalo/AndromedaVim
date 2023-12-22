return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts) Andromeda.kit.extend_list_opt(opts, { "black" }) end,
  },
}
