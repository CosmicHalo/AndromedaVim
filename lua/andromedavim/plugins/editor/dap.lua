local dapui_cfg = Andromeda.load_config "nvim-dapui"

return {
  "mfussenegger/nvim-dap",
  event = "User AndromedaFile",
  enabled = vim.fn.has "win32" == 0,
  dependencies = {
    { "AstroNvim/astrocore", opts = Andromeda.load_config "nvim-dap" },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "nvim-dap" },
      cmd = { "DapInstall", "DapUninstall" },
      opts = { handlers = {} },
    },
    {
      "rcarriga/nvim-dap-ui",
      config = dapui_cfg.config,
      opts = { floating = { border = "rounded" } },
      dependencies = { { "AstroNvim/astrocore", opts = dapui_cfg.mappings } },
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
