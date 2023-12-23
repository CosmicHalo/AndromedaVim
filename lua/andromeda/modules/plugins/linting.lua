return {
  {
    "mfussenegger/nvim-lint",
    event = "User AndromedaFile",
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },

      linters_by_ft = {
        json = {},
        text = {},
        toml = {},
        gitcommit = {},
        javascript = {},
        nix = { "nix" },
        typescript = {},
        lua = { "stylua" },
        css = { "stylelint" },
        python = { "pylint" },
        sh = { "shellcheck" },
        yaml = { "yamllint" },
        markdown = { "markdownlint" },
      },

      -- AndromedaVim extension to easily override linter options
      -- or add custom linters.
      ---@type table<string,table>
      linters = {
        -- selene = {
        --   condition = function(ctx) return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1] end,
        -- },
      },
    },

    config = require("configs.nvim-lint"),
  },
}
