Andromeda.configs.indentscope = {
  ignore_filetypes = {
    "NvimTree",
    "Trouble",
    "aerial",
    "alpha",
    "dashboard",
    "help",
    "lazy",
    "mason",
    "neo-tree",
    "neogitstatus",
    "notify",
    "startify",
    "toggleterm",
  },

  ignore_buftypes = {
    "nofile",
    "prompt",
    "quickfix",
    "terminal",
  },

  config = function(_, opts)
    local maps = opts.mappings

    maps.n["<leader>uI"] = {
      function() require("astrocore.toggles").buffer_indent_guides() end,
      desc = "Toggle indent guides (buffer)",
    }

    opts.autocmds.indentscope_disabled = {
      {
        event = "FileType",
        desc = "Disable indentscope for certain filetypes",
        callback = function(event)
          if vim.b[event.buf].minicursorword_disable == nil then
            local filetype = vim.bo[event.buf].filetype
            local blankline_opts = require("astrocore").plugin_opts("indent-blankline.nvim")
            if
              vim.tbl_contains(
                blankline_opts.filetype_exclude or Andromeda.configs.indentscope.ignore_filetypes,
                filetype
              )
            then
              vim.b[event.buf].miniindentscope_disable = true
            end
          end
        end,
      },
      {
        event = "BufWinEnter",
        desc = "Disable indentscope for certain buftypes",
        callback = function(event)
          if vim.b[event.buf].minicursorword_disable == nil then
            local buftype = vim.bo[event.buf].buftype
            local blankline_opts = require("astrocore").plugin_opts("indent-blankline.nvim")
            if
              vim.tbl_contains(blankline_opts.buftype_exclude or Andromeda.configs.indentscope.ignore_buftypes, buftype)
            then
              vim.b[event.buf].miniindentscope_disable = true
            end
          end
        end,
      },
      {
        event = "TermOpen",
        desc = "Disable indentscope for terminals",
        callback = function(event)
          if vim.b[event.buf].minicursorword_disable == nil then vim.b[event.buf].miniindentscope_disable = true end
        end,
      },
    }
  end,
}
