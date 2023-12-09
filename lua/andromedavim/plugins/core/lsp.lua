---@diagnostic disable: missing-fields
return {
  "AstroNvim/astrolsp",
  lazy = false,
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

  ---@type AstroLSPOpts
  opts = {
    flags = {},
    on_attach = nil,

    formatting = {
      disabled = {},
      format_on_save = { enabled = true },
    },

    features = {
      codelens = true,
      autoformat = true,
      inlay_hints = false,
      lsp_handlers = true,
      diagnostics_mode = 3,
      semantic_tokens = true,
    },

    capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
      textDocument = {
        completion = {
          completionItem = {
            documentationFormat = { "markdown", "plaintext" },
            snippetSupport = true,
            preselectSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            deprecatedSupport = true,
            commitCharactersSupport = true,
            tagSupport = { valueSet = { 1 } },
            resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" } },
          },
        },

        foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
      },
    }),

    servers = {},

    ---@diagnostic disable-next-line: missing-fields
    config = {
      lua_ls = {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            completion = { callSnippet = "Replace" },
          },
        },
      },
    },

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
  },
}
