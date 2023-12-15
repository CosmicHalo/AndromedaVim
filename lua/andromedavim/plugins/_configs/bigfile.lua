Andromeda.configs.bigfile = function()
  local ftdetect = {
    name = "ftdetect",
    opts = { defer = true },
    disable = function() vim.api.nvim_set_option_value("filetype", "big_file_disabled_ft", { scope = "local" }) end,
  }

  local cmp = {
    name = "nvim-cmp",
    opts = { defer = true },
    disable = function() require("cmp").setup.buffer({ enabled = false }) end,
  }

  return {
    filesize = 1, -- size of the file in MiB
    pattern = { "*" }, -- autocmd pattern
    features = { -- features to disable
      "lsp",
      "illuminate",
      "treesitter",
      "syntax",
      "vimopts",
      ftdetect,
      cmp,
    },
  }
end
