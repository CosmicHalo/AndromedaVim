return {
  "folke/noice.nvim",
  event = { "User AndromedaFile", "VeryLazy" },
  dependencies = {
    { "MunifTanjim/nui.nvim", lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "AstroNvim/astrocore", opts = Andromeda.mappings.noice },
  },
  -- stylua: ignore
  keys = {
    { 
      "<c-f>",
      function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
      silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
    {
      "<c-b>",
      function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
      silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
  },

  opts = {
    presets = {
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      lsp_doc_border = true, -- add a border to hover docs and signature help
      long_message_to_split = true, -- long messages will be sent to a split
      cmdline_output_to_split = false, -- send the output of a command you executed in the cmdline to a split
    },

    lsp = {
      override = {
        ["cmp.entry.get_documentation"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      },
    },

    commands = {
      -- options for the message history that you get with `:Noice`
      all = {
        filter = {},
        view = "split",
        opts = { enter = true, format = "details" },
      },
    },

    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
  },

  config = function(_, opts)
    local focused = true
    vim.api.nvim_create_autocmd("FocusGained", {
      callback = function() focused = true end,
    })

    vim.api.nvim_create_autocmd("FocusLost", {
      callback = function() focused = false end,
    })

    table.insert(opts.routes, {
      filter = {
        event = "notify",
        find = "No information available",
      },
      opts = { skip = true },
    })

    table.insert(opts.routes, 1, {
      filter = {
        ["not"] = {
          event = "lsp",
          kind = "progress",
        },
        cond = function() return not focused end,
      },
      view = "notify_send",
      opts = { stop = false },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function(event)
        vim.schedule(function() require("noice.text.markdown").keys(event.buf) end)
      end,
    })

    require("noice").setup(opts)
  end,
}
