return {
  "AstroNvim/astrolsp",
  lazy = true,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>ud"] = { function() require("astrolsp.toggles").diagnostics() end, desc = "Toggle diagnostics" }
        maps.n["<Leader>uL"] = { function() require("astrolsp.toggles").codelens() end, desc = "Toggle CodeLens" }
      end,
    },
  },
  opts = function(_, opts)
    ---@type AstroLSPOpts
    local new_opts = {
      flags = {},
      on_attach = nil,

      features = {
        codelens = true,
        autoformat = true,
        inlay_hints = true,
        lsp_handlers = false,
        diagnostics_mode = 3,
        semantic_tokens = true,
      },

      formatting = {
        format_on_save = {
          enabled = true,
        },
      },

      capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
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
      }),

      -- >>>>>>>>>>>>>>> LSP Server Settings <<<<<<<<<<<<<<<<

      servers = {},

      ---@diagnostic disable-next-line: missing-fields
      config = { lua_ls = { settings = { Lua = { workspace = { checkThirdParty = false } } } } },

      handlers = { function(server, server_opts) require("lspconfig")[server].setup(server_opts) end },

      -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

      diagnostics = {
        underline = true,
        virtual_text = true,
        severity_sort = true,
        update_in_insert = true,

        float = {
          prefix = "",
          header = "",
          focused = false,
          style = "minimal",
          border = "rounded",
          source = "always",
        },

        signs = {
          text = {
            [vim.diagnostic.severity.HINT] = Andromeda.icons.diagnostics.Hint,
            [vim.diagnostic.severity.ERROR] = Andromeda.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = Andromeda.icons.diagnostics.Warning,
            [vim.diagnostic.severity.INFO] = Andromeda.icons.diagnostics.Information,
          },
        },
      },

      signs = {
        {
          name = "DapLogPoint",
          texthl = "DiagnosticInfo",
          text = Andromeda.icons.dap.LogPoint,
        },
        {
          name = "DapStopped",
          texthl = "DiagnosticWarn",
          text = Andromeda.icons.dap.Stopped,
        },
        {
          name = "DapBreakpoint",
          texthl = "DiagnosticInfo",
          text = Andromeda.icons.dap.Breakpoint,
        },
        {
          texthl = "DiagnosticInfo",
          name = "DapBreakpointCondition",
          text = Andromeda.icons.dap.BreakpointCondition,
        },
        {
          texthl = "DiagnosticError",
          name = "DapBreakpointRejected",
          text = Andromeda.icons.dap.BreakpointRejected,
        },
      },
    }

    return Andromeda.lib.extend_tbl(opts, new_opts)
  end,
}
