return {
  {
    "rshkarin/mason",
    optional = true,
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "eslint_d" }) end,
  },

  -- add typescript to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "javascript", "typescript", "tsx" }) end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {},
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

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
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
      },
    },
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
  --             type = "pwa-node",
  --             request = "attach",
  --             name = "Attach",
  --             processId = require("dap.utils").pick_process,
  --             cwd = "${workspaceFolder}",
  --           },
  --         }
  --       end
  --     end
  --   end,
  -- },
}
