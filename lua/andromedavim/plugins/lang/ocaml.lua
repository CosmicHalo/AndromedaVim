return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then vim.list_extend(opts.ensure_installed, { "ocaml" }) end
    end,
  },

  {
    "AstroNvim/astrolsp",
    opts = {
      servers = { "ocamllsp" },
      config = { ocamllsp = { codelens = { enable = true } } },
    },
  },
}
