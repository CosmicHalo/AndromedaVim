local icons = Andromeda.icons

return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = { { "AstroNvim/astrocore", opts = Andromeda.mappings.mason } },
    cmd = { "Mason", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
    opts = {

      ensure_installed = {
        "shfmt",
        "stylua",
        "flake8",
        "prettier",
        "eslint_d",
        "shellcheck",
        "lua-language-server",
      },

      ui = {
        border = Andromeda.settings.ui.float.border,

        icons = {
          package_installed = icons.ui.Check,
          package_uninstalled = icons.misc.Ghost,
          package_pending = icons.ui.Modified_alt,
        },
      },
    },

    config = function(_, opts)
      require("mason").setup(opts)

      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end

      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    init = function(plugin) require("astrocore").on_load("mason.nvim", plugin.name) end,
    opts = function(_, opts)
      vim.defer_fn(function()
        if not opts.handlers then opts.handlers = {} end
        opts.handlers[1] = function(server) require("astrolsp").lsp_setup(server) end
      end, 0)
    end,
  },
}
