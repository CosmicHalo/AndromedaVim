return {
  -- add typescript to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) Andromeda.kit.extend_list_opt(opts, { "javascript", "typescript", "tsx" }) end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts) Andromeda.kit.extend_list_opt(opts, { "tsserver" }) end,
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, { nls.builtins.formatting.eslint_d })
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["vue"] = { "prettier" },
        ["css"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["html"] = { "prettier" },
        ["json"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["jsonc"] = { "prettier" },
        ["graphql"] = { "prettier" },
        ["markdown"] = { "prettier" },
        ["javascript"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["handlebars"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
      },
    },
  },

  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      Andromeda.kit.extend_list_opt(opts, { "tsserver" }, "servers")

      opts.config = table.extend(opts.config or {}, {
        tsserver = {
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayVariableTypeHints = false,
                includeInlayEnumMemberValueHints = true,
                includeInlayParameterNameHints = "literal",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              },
            },

            javascript = {
              inlayHints = {
                includeInlayVariableTypeHints = true,
                includeInlayParameterNameHints = "all",
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              },
            },
          },
        },
      })
    end,
  },

  -- {
  --   "mfussenegger/nvim-dap",
  --   optional = true,
  --   dependencies = {
  --     {
  --       "williamboman/mason.nvim",
  --       opts = function(_, opts)
  --         opts.ensure_installed = opts.ensure_installed or {}
  --         table.insert(opts.ensure_installed, "js-debug-adapter")
  --       end,
  --     },
  --   },

  --   opts = function()
  --     local dap = require("dap")

  --     if not dap.adapters["pwa-node"] then
  --       require("dap").adapters["pwa-node"] = {
  --         type = "server",
  --         host = "localhost",
  --         port = "${port}",
  --         executable = {
  --           command = "node",
  --           -- 💀 Make sure to update this path to point to your installation
  --           args = {
  --             require("mason-registry").get_package("js-debug-adapter"):get_install_path()
  --               .. "/js-debug/src/dapDebugServer.js",
  --             "${port}",
  --           },
  --         },
  --       }
  --     end

  --     for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  --       if not dap.configurations[language] then
  --         dap.configurations[language] = {
  --           {
  --             type = "pwa-node",
  --             request = "launch",
  --             name = "Launch file",
  --             program = "${file}",
  --             cwd = "${workspaceFolder}",
  --           },
  --           {
  --             name = "Attach",
  --             type = "pwa-node",
  --             request = "attach",
  --             cwd = "${workspaceFolder}",
  --             processId = require("dap.utils").pick_process,
  --           },
  --         }
  --       end
  --     end
  --   end,
  -- },
}
