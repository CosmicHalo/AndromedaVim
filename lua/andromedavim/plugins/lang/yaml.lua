---@diagnostic disable: missing-fields
return {
  -- add yaml specific modules to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "yaml" }) end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "yamlls" }) end,
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, { nls.builtins.formatting.yamlfmt })
    end,
  },

  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
    dependencies = {
      {
        "AstroNvim/astrolsp",
        opts = function(_, opts)
          Andromeda.lib.extend_list_opt(opts, { "yamlls" }, "servers")
          opts.config = Andromeda.lib.extend_tbl(opts.config or {}, {
            yamlls = {
              on_new_config = function(config)
                config.settings.yaml.schemas = vim.tbl_deep_extend(
                  "force",
                  config.settings.yaml.schemas or {},
                  require("schemastore").yaml.schemas()
                )
              end,

              -- Have to add this for yamlls to understand that we support line folding
              capabilities = {
                textDocument = {
                  foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true,
                  },
                },
              },

              settings = {
                redhat = {
                  telemetry = { enabled = false },
                },

                yaml = {
                  validate = true,
                  keyOrdering = false,
                  format = { enable = true },
                  schemaStore = {
                    -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                    url = "",
                    -- Must disable built-in schemaStore support to use
                    -- schemas from SchemaStore.nvim plugin
                    enable = false,
                  },
                },
              },
            },
          })
        end,
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["yaml"] = { "yamlfmt" },
      },
    },
  },
}
