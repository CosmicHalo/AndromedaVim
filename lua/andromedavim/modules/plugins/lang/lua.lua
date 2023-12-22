return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts) Andromeda.kit.extend_list_opt(opts, { "lua_ls" }, "servers") end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) Andromeda.kit.extend_list_opt(opts, { "lua", "luap" }) end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts) Andromeda.kit.extend_list_opt(opts, { "lua_ls" }) end,
  },
  {
    "nvimtools/none-ls.nvim",
    lazy = false,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.stylua,
        nls.builtins.diagnostics.luacheck,
      })
    end,
  },
}
