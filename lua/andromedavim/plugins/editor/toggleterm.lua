return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm", "TermExec" },
  dependencies = { { "AstroNvim/astrocore", opts = Andromeda.mappings.neotree } },
  opts = {
    size = 10,
    shading_factor = 2,
    direction = "float",
    open_mapping = [[<F7>]],
    float_opts = { border = "rounded" },

    on_create = function()
      vim.opt.foldcolumn = "0"
      vim.opt.signcolumn = "no"
    end,

    highlights = {
      Normal = { link = "Normal" },
      WinBar = { link = "WinBar" },
      NormalNC = { link = "NormalNC" },
      WinBarNC = { link = "WinBarNC" },
      StatusLine = { link = "StatusLine" },
      NormalFloat = { link = "NormalFloat" },
      FloatBorder = { link = "FloatBorder" },
      StatusLineNC = { link = "StatusLineNC" },
    },
  },
}
