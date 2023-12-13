return {
  {
    "stevearc/conform.nvim",
    lazy = true,
    cmd = "ConformInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { { "AstroNvim/astrocore", opts = Andromeda.mappings.conform_nvim } },

    init = Andromeda.configs["conform_nvim"].init,
    config = function(_, opts) require("conform").setup(opts) end,
    opts = function()
      ---@class ConformOpts
      local opts = {
        format = {
          timeout_ms = 3000,
          async = false, -- not recommended to change
          quiet = false, -- not recommended to change
        },

        ---@type table<string, conform.FormatterUnit[]>
        formatters_by_ft = {
          sh = { "shfmt" },
          lua = { "stylua" },
          nix = { "alejandra" },
          fish = { "fish_indent" },
          python = { "isort", "black" },
        },

        formatters = {
          injected = { options = { ignore_errors = true } },
          -- # Example of using dprint only when a dprint.json file is present
          -- dprint = {
          --   condition = function(ctx)
          --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          --   end,
          -- },
          --
          -- # Example of using shfmt with extra args
          -- shfmt = {
          --   prepend_args = { "-i", "2", "-ci" },
          -- },
        },
      }

      return opts
    end,
  },
}
