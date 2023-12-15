return {
  "mfussenegger/nvim-dap",
  lazy = true,
  event = "User AndromedaFile",
  enabled = vim.fn.has("win32") == 0,
  dependencies = {
    { "AstroNvim/astrocore", opts = Andromeda.mappings.dap },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "nvim-dap" },
      cmd = { "DapInstall", "DapUninstall" },
      opts = { handlers = {} },
      init = function()
        require("astrocore").on_load("mason.nvim", function() require("mason-nvim-dap") end)
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      config = Andromeda.configs.dapui,
      opts = { floating = { border = "rounded" } },
      dependencies = { { "AstroNvim/astrocore", opts = Andromeda.mappings.dapui } },
    },
    {
      "rcarriga/cmp-dap",
      dependencies = { "nvim-cmp" },
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
          sources = {
            { name = "dap" },
          },
        })
      end,
    },
  },
}
