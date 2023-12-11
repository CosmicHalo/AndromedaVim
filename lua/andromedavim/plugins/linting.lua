return {
  {
    "mfussenegger/nvim-lint",
    event = "User AndromedaFile",
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },

      linters_by_ft = {
        -- nix = { "nix" },
        markdown = { "markdownlint" },
        lua = { "selene" },
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

    config = Andromeda.load_config "nvim-lint",
  },

  {
    "rshkarin/mason-nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = function(_, opts)
      local ensure_installed = opts.ensure_installed or {}
      vim.list_extend(ensure_installed, { "selene" })

      -- Andromeda.debug("ensure_installed", ensure_installed)

      return {
        automatic_installation = true,
        ensure_installed = ensure_installed,
      }
    end,
  },
}
