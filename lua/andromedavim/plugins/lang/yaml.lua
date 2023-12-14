---@diagnostic disable: missing-fields
return {

  -- add yaml specific modules to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "yaml" }) end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "yaml-language-server" }) end,
  },

  -- yaml schema support
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
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

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          -- Have to add this for yamlls to understand that we support line folding
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },

          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas()
            )
          end,

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
      },
    },
  },

  -- {
  --   "AstroNvim/astrolsp",
  --   opts = function(_, opts)
  --     opts.servers = vim.list_extend(opts.servers, { "yamlls" })
  --     -- opts.handlers = require("andromedavim.libs").extend_opts(opts.handlers, {
  --     --   yamlls = function(_, opts)
  --     --     -- Neovim < 0.10 does not have dynamic registration for formatting
  --     --     if vim.fn.has "nvim-0.10" == 0 then
  --     --       require("andromedavim.libs").lsp.on_attach(function(client, _)
  --     --         if client.name == "yamlls" then client.server_capabilities.documentFormattingProvider = true end
  --     --       end)
  --     --     end

  --     --     ---@diagnostic disable-next-line: undefined-field
  --     --     require("lspconfig").yamlls.setup(opts)
  --     --   end,
  --     -- })
  --   end,
  -- },
}
