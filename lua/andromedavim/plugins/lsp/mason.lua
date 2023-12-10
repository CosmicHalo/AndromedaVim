local deps = {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<Leader>pm"] = { function() require("mason.ui").open() end, desc = "Mason Installer" }
      maps.n["<Leader>pM"] = { function() require("astrocore.mason").update_all() end, desc = "Mason Update" }

      opts.commands.AstroMasonUpdate = {
        function(options) require("astrocore.mason").update(options.fargs) end,
        nargs = "*",
        desc = "Update Mason Package",
        complete = function(arg_lead)
          local _ = require "mason-core.functional"
          return _.sort_by(
            _.identity,
            _.filter(_.starts_with(arg_lead), require("mason-registry").get_installed_package_names())
          )
        end,
      }

      opts.commands.AstroMasonUpdateAll = {
        desc = "Update Mason Packages",
        function() require("astrocore.mason").update_all() end,
      }
    end,
  },
}

local icons = require "andromedavim.icons"
return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = {
      "Mason",
      "MasonLog",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
    },

    dependencies = deps,

    opts = {

      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },

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

  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {},
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "prettier",
        "stylua",
        "eslint_d",
      })
    end,
  },
}
