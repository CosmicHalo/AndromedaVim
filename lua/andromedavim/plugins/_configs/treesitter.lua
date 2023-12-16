Andromeda.configs.treesitter = {
  config = function(_, opts)
    opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
      "bash",
      "diff",
      "html",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "query",
      "regex",
      "toml",
      "vim",
      "vimdoc",
    })

    if type(opts.ensure_installed) == "table" then
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(parser)
        if added[parser] then return false end
        added[parser] = true
        return true
      end, opts.ensure_installed)
    end

    require("nvim-treesitter.configs").setup(opts)
  end,
}
