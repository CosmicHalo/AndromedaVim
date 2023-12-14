---@diagnostic disable: missing-fields
return {
  "AstroNvim/astrolsp",
  lazy = false,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>uL"] = { function() require("astrolsp.toggles").codelens() end, desc = "Toggle CodeLens" }
        maps.n["<Leader>ud"] = { function() require("astrolsp.toggles").diagnostics() end, desc = "Toggle diagnostics" }
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
}
