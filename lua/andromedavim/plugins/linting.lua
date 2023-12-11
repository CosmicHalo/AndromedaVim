return {
  {
    "mfussenegger/nvim-lint",
    event = "User AndromedaFile",
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },

      linters_by_ft = {
        -- nix = { "nix" },
        lua = { "selene" },
        markdown = { "markdownlint" },
        -- lua = { "selene", "luacheck" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
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

    config = Andromeda.configs.nvim_lint,
  },
}
