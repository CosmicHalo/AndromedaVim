local icons = require "andromedavim.icons"

return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = { { "AstroNvim/astrocore", opts = Andromeda.load_config "mason" } },
    cmd = { "Mason", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
    opts = {
      ensure_installed = { "stylua", "shellcheck", "shfmt", "flake8" },

      ui = {
        icons = {
          package_pending = icons.PackagePending,
          package_installed = icons.PackageLoaded,
          package_uninstalled = icons.PackageUninstalled,
        },
      },
    },

    config = function(_, opts)
      require("mason").setup(opts)
      vim.tbl_map(function(mod) pcall(require, mod) end, { "mason-lspconfig", "mason-null-ls", "mason-nvim-dap" })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "lua_ls",
      })
    end,
  },

  -- {
  --   "jay-babu/mason-null-ls.nvim",
  --   dependencies = {},
  --   opts = function(_, opts)
  --     -- add more things to the ensure_installed table protecting against community packs modifying it
  --     opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
  --       "prettier",
  --       "stylua",
  --       "eslint_d",
  --     })
  --   end,
  -- },
}
