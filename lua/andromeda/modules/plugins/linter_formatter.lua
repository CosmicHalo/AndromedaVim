local settings = Andromeda.settings

local plugins = settings.plugins
local linting = settings.linting
local formatting = settings.formatting

return {
  { -- auto-install missing linters & formatters
    -- (auto-install of lsp servers done via `mason-lspconfig.nvim`)
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = "williamboman/mason.nvim",
    config = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsStartingInstall",
        callback = function()
          vim.schedule(function() Andromeda.kit.notify("mason-tool-installer is starting") end)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsUpdateCompleted",
        callback = function(e)
          vim.schedule(
            function()
              Andromeda.kit.notify(vim.inspect(e.data), vim.log.levels.INFO, {
                title = "AndromedaVim Mason Tool Installer",
                icon = "",
              })
            end
          )
        end,
      })

      require("mason-tool-installer").setup({
        auto_update = true,
        start_delay = 2000,
        run_on_start = true,
        ensure_installed = plugins.formatters_linters,
      })
    end,
  },

  --! Linter
  {
    "mfussenegger/nvim-lint",
    event = "User AndromedaFile",
    opts = {
      linters = linting.linters,
      linters_by_ft = linting.linters_by_ft,
      events = { "BufWritePost", "BufReadPost", "InsertLeave" }, -- Event to trigger linters
    },
    config = require("configs.lint_format.nvim-lint"),
  },

  --! Formatter
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      Andromeda.kit.add_mappings({
        ["<leader>cF"] = {
          function() require("conform").format({ formatters = { "injected" } }) end,
          desc = "Format Injected Langs",
        },
      }),
    },
    init = function()
      -- Install the conform formatter on VeryLazy
      Andromeda.kit.on_very_lazy(function()
        Andromeda.kit.format.register({
          priority = 100,
          primary = true,
          name = "conform.nvim",

          format = function(buf)
            local opts = require("astrocore").plugin_opts("conform.nvim")
            ---@diagnostic disable-next-line: undefined-field
            require("conform").format(Andromeda.kit.merge(opts.format, { bufnr = buf }))
          end,

          sources = function(buf)
            ---@diagnostic disable-next-line: undefined-field
            local ret = require("conform").list_formatters(buf)
            ---@param v conform.FormatterInfo
            return vim.tbl_map(function(v) return v.name end, ret)
          end,
        })
      end)
    end,

    opts = {
      formatters = formatting.formatters,
      formatters_by_ft = formatting.formatters_by_ft,

      format = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
      },
    },

    config = function(_, opts) require("conform").setup(opts) end,
  },
}
