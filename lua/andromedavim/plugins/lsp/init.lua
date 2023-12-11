return {
  ---@diagnostic disable: missing-fields
  {
    "AstroNvim/astrolsp",
    lazy = false,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>ud"] =
            { function() require("astrolsp.toggles").diagnostics() end, desc = "Toggle diagnostics" }
          maps.n["<Leader>uL"] = { function() require("astrolsp.toggles").codelens() end, desc = "Toggle CodeLens" }
        end,
      },
    },

    opts = function(_, opts)
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(), -- Lsp capabilities
        has_cmp and cmp_nvim_lsp.default_capabilities() or {}, -- Cmp capabilities
        -- Custom capabilities
        {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true,
                preselectSupport = true,
                deprecatedSupport = true,
                labelDetailsSupport = true,
                insertReplaceSupport = true,
                commitCharactersSupport = true,
                tagSupport = { valueSet = { 1 } },
                documentationFormat = { "markdown", "plaintext" },
                resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" } },
              },
            },

            foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
          },
        }
      )

      ---@type AstroLSPOpts
      return {
        flags = {},
        on_attach = nil,
        capabilities = capabilities,

        formatting = {
          disabled = {},
          timeout_ms = 1000, -- default format timeout
          format_on_save = { enabled = true, allow_filetypes = {}, ignore_filetypes = {} },
        },

        features = {
          codelens = true,
          autoformat = true,
          inlay_hints = false,
          lsp_handlers = true,
          diagnostics_mode = 3,
          semantic_tokens = true,
        },

        servers = {},

        ---@diagnostic disable-next-line: missing-fields
        config = {},

        handlers = {
          function(server, server_opts) require("lspconfig")[server].setup(server_opts) end,
        },

        diagnostics = {
          underline = true,
          virtual_text = true,
          severity_sort = true,
          update_in_insert = true,

          float = {
            header = "",
            prefix = "",
            focused = false,
            style = "minimal",
            source = "always",
            border = "rounded",
          },

          signs = {
            active = {
              { name = "DiagnosticSignError", text = "", texthl = "DiagnosticSignError" },
              { name = "DiagnosticSignHint", text = "󰌵", texthl = "DiagnosticSignHint" },
              { name = "DiagnosticSignInfo", text = "󰋼", texthl = "DiagnosticSignInfo" },
              { name = "DiagnosticSignWarn", text = "", texthl = "DiagnosticSignWarn" },
              { name = "DapBreakpoint", text = "", texthl = "DiagnosticInfo" },
              { name = "DapBreakpointCondition", text = "", texthl = "DiagnosticInfo" },
              { name = "DapBreakpointRejected", text = "", texthl = "DiagnosticError" },
              { name = "DapLogPoint", text = ".>", texthl = "DiagnosticInfo" },
              { name = "DapStopped", text = "󰁕", texthl = "DiagnosticWarn" },
            },
          },
        },
      }
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "User AndromedaFile",
    cmd = function(_, cmds) -- HACK: lazy load lspconfig on `:Neoconf` if neoconf is available
      if require("astrocore").is_available "neoconf.nvim" then table.insert(cmds, "Neoconf") end
      vim.list_extend(cmds, { "LspInfo", "LspLog", "LspStart" }) -- add normal `nvim-lspconfig` commands
    end,

    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },

      -- {
      --   "AstroNvim/astrolsp",
      --   opts = function(_, opts)
      --     local maps = opts.mappings
      --     maps.n["<Leader>li"] = {
      --       "<Cmd>LspInfo<CR>",
      --       desc = "LSP information",
      --       cond = function() return vim.fn.exists ":LspInfo" > 0 end,
      --     }
      --   end,
      -- },
    },

    config = function(_, opts)
      local astrocore = require "astrocore"
      local astrolsp = require "astrolsp"
      local Lib = require "andromedavim.libs"

      -- setup autoformat
      Lib.format.register(Lib.lsp.formatter())

      Andromeda.debug("LSP handler: ", opts)
      -- Andromeda.debug("LSP handler: ", astrolsp.config.servers)

      local setup_servers = function()
        vim.tbl_map(require("astrolsp").lsp_setup, require("astrolsp").config.servers)
        vim.api.nvim_exec_autocmds("FileType", {})
        require("andromedavim.libs").event "LspSetup"
      end

      if astrocore.is_available "mason-lspconfig.nvim" then
        astrocore.on_load("mason-lspconfig.nvim", setup_servers)
      else
        setup_servers()
      end

      --! Setup Deno over TSServer
      if Lib.lsp.get_config "denols" and Lib.lsp.get_config "tsserver" then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        Lib.lsp.disable("tsserver", is_deno)
        Lib.lsp.disable("denols", function(root_dir) return not is_deno(root_dir) end)
      end
    end,
  },
}
