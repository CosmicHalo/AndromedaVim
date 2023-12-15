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
    local icons = {
      dap = Andromeda.icons.dap.get,
      diagnostics = Andromeda.icons.diagnostics.get,
    }

    ---@type AstroLSPOpts
    local new_opts = {
      flags = {},
      on_attach = nil,

      formatting = {
        disabled = {},
        format_on_save = { enabled = true },
      },

      features = {
        codelens = true,
        autoformat = true,
        inlay_hints = true,
        diagnostics_mode = 3,
        lsp_handlers = false,
        semantic_tokens = true,
      },

      diagnostics = {
        underline = true,
        virtual_text = true,
        severity_sort = true,
        update_in_insert = true,

        float = {
          focused = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },

        signs = {
          text = {
            [vim.diagnostic.severity.HINT] = icons.diagnostics("Hint"),
            [vim.diagnostic.severity.ERROR] = icons.diagnostics("Error"),
            [vim.diagnostic.severity.WARN] = icons.diagnostics("Warning"),
            [vim.diagnostic.severity.INFO] = icons.diagnostics("Information"),
          },
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

      signs = {
        {
          name = "DapBreakpoint",
          texthl = "DiagnosticInfo",
          text = icons.dap("Breakpoint"),
        },
        {
          texthl = "DiagnosticInfo",
          name = "DapBreakpointCondition",
          text = icons.dap("BreakpointCondition"),
        },
        {
          texthl = "DiagnosticError",
          name = "DapBreakpointRejected",
          text = icons.dap("BreakpointRejected"),
        },
        {
          name = "DapLogPoint",
          texthl = "DiagnosticInfo",
          text = icons.dap("LogPoint"),
        },
        {
          name = "DapStopped",
          texthl = "DiagnosticWarn",
          text = icons.dap("Stopped"),
        },
      },

      servers = { "lua_ls" },

      ---@diagnostic disable-next-line: missing-fields
      config = { lua_ls = { settings = { Lua = { workspace = { checkThirdParty = false } } } } },

      handlers = { function(server, server_opts) require("lspconfig")[server].setup(server_opts) end },
    }
    return require("astrocore").extend_tbl(opts, new_opts)
  end,
}
