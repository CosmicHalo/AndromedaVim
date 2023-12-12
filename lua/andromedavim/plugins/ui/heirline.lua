---@class AstroStatus
---@field hl astroui.status.hl
---@field init astroui.status.init
---@field utils astroui.status.utils
---@field heirline astroui.status.heirline
---@field provider astroui.status.provider
---@field condition astroui.status.condition
---@field component astroui.status.component

return {
  "rebelot/heirline.nvim",
  event = "BufEnter",
  dependencies = { { "AstroNvim/astrocore", opts = Andromeda.mappings.heirline } },
  opts = function()
    local status = require "astroui.status" --[[@as AstroStatus]]

    return {
      opts = {
        colors = require("astroui").config.status.setup_colors(),

        disable_winbar_cb = function(args)
          return not require("astrocore.buffer").is_valid(args.buf)
            or status.condition.buffer_matches({ buftype = { "terminal", "nofile" } }, args.buf)
        end,
      },

      statuscolumn = {
        init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
        status.component.foldcolumn(),
        status.component.numbercolumn(),
        status.component.signcolumn(),
      },

      statusline = { -- statusline
        hl = { fg = "fg", bg = "bg" },
        status.component.mode(),
        status.component.git_branch(),
        status.component.file_info(),
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.virtual_env(),
        status.component.treesitter(),
        status.component.nav(),
        status.component.mode { surround = { separator = "right" } },
      },

      winbar = { -- winbar
        fallthrough = false,
        init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
        {
          condition = function() return not status.condition.is_active() end,
          status.component.separated_path(),
          status.component.file_info {
            file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
            filename = {},
            filetype = false,
            file_read_only = false,
            hl = status.hl.get_attributes("winbarnc", true),
            surround = false,
            update = "BufEnter",
          },
        },
        status.component.breadcrumbs { hl = status.hl.get_attributes("winbar", true) },
      },

      tabline = { -- bufferline
        { -- file tree padding
          condition = function(self)
            self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
            return status.condition.buffer_matches({
              filetype = {
                "NvimTree",
                "OverseerList",
                "aerial",
                "dap%-repl",
                "dapui_.",
                "edgy",
                "neo%-tree",
                "undotree",
              },
            }, vim.api.nvim_win_get_buf(self.winid))
          end,
          provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid) + 1) end,
          hl = { bg = "tabline_bg" },
        },
        status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab
        status.component.fill { hl = { bg = "tabline_bg" } }, -- fill the rest of the tabline with background color
        { -- tab list
          condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
          status.heirline.make_tablist { -- component for each tab
            provider = status.provider.tabnr(),
            hl = function(self) return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true) end,
          },
          { -- close button for current tab
            provider = status.provider.close_button { kind = "TabClose", padding = { left = 1, right = 1 } },
            hl = status.hl.get_attributes("tab_close", true),
            on_click = {
              callback = function() require("astrocore.buffer").close_tab() end,
              name = "heirline_tabline_close_tab_callback",
            },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    require("heirline").setup(opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "AstroColorScheme",
      group = vim.api.nvim_create_augroup("Heirline", { clear = true }),
      desc = "Refresh heirline colors",
      callback = function() require("astroui.status.heirline").refresh_colors() end,
    })
  end,
}
