return {
  "mfussenegger/nvim-dap",
  event = "User AndromedaFile",
  enabled = vim.fn.has("win32") == 0,
  dependencies = {
    Andromeda.kit.add_mappings("dap"),

    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "nvim-dap" },
      cmd = { "DapInstall", "DapUninstall" },
      opts = { handlers = {} },
      init = function(plugin) require("astrocore").on_load("mason.nvim", plugin.name) end,
    },

    {
      "rcarriga/nvim-dap-ui",
      config = Andromeda.configs.dapui,
      opts = { floating = { border = Andromeda.settings.ui.float.border } },
      dependencies = { { "AstroNvim/astrocore", opts = Andromeda.mappings.dapui } },
    },

    {
      "rcarriga/cmp-dap",
      dependencies = { "nvim-cmp" },
      config = function()
        require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
          sources = {
            { name = "dap" },
          },
        })
      end,
    },
  },
}
