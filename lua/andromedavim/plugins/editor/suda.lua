return {
  "lambdalisue/suda.vim",
  lazy = true,
  cmd = { "SudaRead", "SudaWrite" },
  opts = {},
  config = function(_, opts)
    vim.g["suda#prompt"] = "Enter administrator password: "
    require("suda").setup(opts)
  end,
}
