return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "ninja", "python", "rst", "toml" }) end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "pyright" }) end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["python"] = { "black" },
      },
    },
  },

  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      Andromeda.lib.extend_list_opt(opts, { "pyright", "ruff_lsp" }, "servers")

      opts.config = Andromeda.lib.extend_tbl(opts.config or {}, {
        ruff_lsp = {
          keys = {
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Organize Imports",
            },
          },
        },
      })

      opts.handlers = Andromeda.lib.extend_tbl(opts.handlers or {}, {
        ruff_lsp = function(_, opts)
          Andromeda.lib.lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)

          ---@diagnostic disable-next-line: undefined-field
          require("lspconfig").ruff_lsp.setup(opts)
        end,
      })
    end,
  },

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
      -- stylua: ignore
      keys = {
        { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
        { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
      },
      config = function()
        local path = require("mason-registry").get_package("debugpy"):get_install_path()
        require("dap-python").setup(path .. "/venv/bin/python")
      end,
    },
  },

  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
    opts = function(_, opts)
      if require("lazyvim.util").has("nvim-dap-python") then opts.dap_enabled = true end
      return vim.tbl_deep_extend("force", opts, {
        name = {
          "venv",
          ".venv",
          "env",
          ".env",
        },
      })
    end,
  },
}
