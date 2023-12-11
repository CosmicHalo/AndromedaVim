return {

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = {
      { "AstroNvim/astrocore", opts = Andromeda.load_config "mason" },
    },

    cmd = { "Mason", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
    opts = function(_, opts)
      local icons = require "andromedavim.icons"

      local ensure_installed = opts.ensure_installed or {}
      ensure_installed = require("astrocore").list_insert_unique(ensure_installed, {
        "prettier",
        "stylua",
        "eslint_d",
        "shellcheck",
        "shfmt",
        "flake8",
      })

      return {
        ensure_installed = ensure_installed,
        ui = {
          icons = {
            package_pending = icons.PackagePending,
            package_installed = icons.PackageLoaded,
            package_uninstalled = icons.PackageUninstalled,
          },
        },
      }
    end,

    config = function(_, opts)
      require("mason").setup(opts)

      local mr = require "mason-registry"
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger {
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          }
        end, 100)
      end)

      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end

      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end

      vim.tbl_map(function(mod) pcall(require, mod) end, { "mason-lspconfig", "mason-null-ls", "mason-nvim-dap" })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    opts = function(_, opts)
      if not opts.handlers then opts.handlers = {} end
      opts.handlers[1] = function(server) require("astrolsp").lsp_setup(server) end
    end,
  },
}
