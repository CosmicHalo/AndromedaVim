return {
  {
    "mfussenegger/nvim-lint",
    event = "User AstroFile",
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },

      linters_by_ft = {
        nix = { "nix" },
        lua = { "stylua" },
        markdown = { "markdownlint" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
      },

      -- AndromedaVim extension to easily override linter options
      -- or add custom linters.
      ---@type table<string,table>
      linters = {
        --   selene = {
        --     condition = function(ctx) return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1] end,
        --   },
        --   luacheck = {
        --     condition = function(ctx) return vim.fs.find({ ".luacheckrc" }, { path = ctx.filename, upward = true })[1] end,
        --   },
      },
    },

    config = Andromeda.load_config "nvim-lint",
  },
}
