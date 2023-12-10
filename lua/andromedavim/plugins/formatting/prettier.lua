return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts) table.insert(opts.ensure_installed, "prettier") end,
  },

  {
    "rshkarin/mason-nvim-lint",
    opts = function(_, opts) require("andromedavim.libs").extend_opt(opts, { "prettier" }) end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {},
    formatters_by_ft = {
      ["vue"] = { "prettier" },
      ["css"] = { "prettier" },
      ["scss"] = { "prettier" },
      ["less"] = { "prettier" },
      ["html"] = { "prettier" },
      ["json"] = { "prettier" },
      ["yaml"] = { "prettier" },
      ["jsonc"] = { "prettier" },
      ["graphql"] = { "prettier" },
      ["markdown"] = { "prettier" },
      ["javascript"] = { "prettier" },
      ["typescript"] = { "prettier" },
      ["handlebars"] = { "prettier" },
      ["markdown.mdx"] = { "prettier" },
      ["javascriptreact"] = { "prettier" },
      ["typescriptreact"] = { "prettier" },
    },
  },
}
