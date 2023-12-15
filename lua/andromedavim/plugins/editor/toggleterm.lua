return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm", "TermExec" },
  dependencies = { { "AstroNvim/astrocore", opts = Andromeda.mappings.neotree } },
  opts = {
    shading_factor = 1,
    direction = "float",
    open_mapping = [[<F7>]],

    shell = vim.o.shell, -- change the default shell
    shade_filetypes = {},
    float_opts = { border = "rounded" },

    persist_size = true, -- when the window is closed, persist its size
    hide_numbers = true, -- hide the number column in toggleterm buffers
    persist_mode = false, -- if true, the terminal persists even when command exits
    close_on_exit = true, -- close the terminal window when the process exits
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    start_in_insert = true,
    shade_terminals = false,

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

    on_open = function()
      -- Prevent infinite calls from freezing neovim.
      -- Only set these options specific to this terminal buffer.
      vim.api.nvim_set_option_value("foldexpr", "0", { scope = "local" })
      vim.api.nvim_set_option_value("foldmethod", "manual", { scope = "local" })
    end,

    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.40
      end
    end,
  },
}
