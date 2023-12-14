return {
  "AstroNvim/astroui",
  ---@param opts AstroUIOpts
  opts = function(_, opts)
    local sign_handlers = {}
    -- gitsigns handlers
    local gitsigns = function(_)
      local gitsigns_avail, gitsigns = pcall(require, "gitsigns")
      if gitsigns_avail then vim.schedule(gitsigns.preview_hunk) end
    end

    for _, sign in ipairs({ "Topdelete", "Untracked", "Add", "Changedelete", "Delete" }) do
      local name = "GitSigns" .. sign
      if not sign_handlers[name] then sign_handlers[name] = gitsigns end
    end

    -- diagnostic handlers
    local diagnostics = function(args)
      if args.mods:find("c") then
        vim.schedule(vim.lsp.buf.code_action)
      else
        vim.schedule(vim.diagnostic.open_float)
      end
    end

    for _, sign in ipairs({ "Error", "Hint", "Info", "Warn" }) do
      local name = "DiagnosticSign" .. sign
      if not sign_handlers[name] then sign_handlers[name] = diagnostics end
    end

    -- DAP handlers
    local dap_breakpoint = function(_)
      local dap_avail, dap = pcall(require, "dap")

      ---@diagnostic disable-next-line: undefined-field
      if dap_avail then vim.schedule(dap.toggle_breakpoint) end
    end

    for _, sign in ipairs({ "", "Rejected", "Condition" }) do
      local name = "DapBreakpoint" .. sign
      if not sign_handlers[name] then sign_handlers[name] = dap_breakpoint end
    end

    opts.status = {
      sign_handlers = sign_handlers,

      separators = {
        path = "  ",
        none = { "", "" },
        tab = { "", " " },
        left = { "", "  " },
        breadcrumbs = "  ",
        right = { "  ", "" },
        center = { "  ", "  " },
      },

      attributes = {
        git_diff = { bold = true },
        git_branch = { bold = true },
        virtual_env = { bold = true },
        buffer_picker = { bold = true },
        macro_recording = { bold = true },
        buffer_active = { bold = true, italic = true },
      },

      icon_highlights = {
        file_icon = {
          statusline = true,
          tabline = function(self) return self.is_active or self.is_visible end,
        },
      },

      fallback_colors = {
        none = "NONE",
        fg = "#abb2bf",
        bg = "#1e222a",
        red = "#e06c75",
        blue = "#61afef",
        grey = "#5c6370",
        green = "#98c379",
        white = "#c9c9c9",
        orange = "#ff9640",
        purple = "#c678dd",
        yellow = "#e5c07b",
        dark_bg = "#2c323c",
        dark_grey = "#5c5c5c",
        bright_red = "#ec5f67",
        bright_grey = "#777d86",
        bright_purple = "#a9a1e1",
        bright_yellow = "#ebae34",
      },

      modes = {
        ["no"] = { "OP", "normal" },
        ["nov"] = { "OP", "normal" },
        ["noV"] = { "OP", "normal" },
        ["no"] = { "OP", "normal" },
        ["V"] = { "LINES", "visual" },
        [""] = { "BLOCK", "visual" },
        [""] = { "BLOCK", "visual" },
        ["n"] = { "NORMAL", "normal" },
        ["i"] = { "INSERT", "insert" },
        ["t"] = { "TERM", "terminal" },
        ["v"] = { "VISUAL", "visual" },
        ["Vs"] = { "LINES", "visual" },
        ["s"] = { "BLOCK", "visual" },
        ["s"] = { "SELECT", "visual" },
        ["S"] = { "SELECT", "visual" },
        ["ic"] = { "INSERT", "insert" },
        ["ix"] = { "INSERT", "insert" },
        ["nt"] = { "TERM", "terminal" },
        ["vs"] = { "VISUAL", "visual" },
        ["rm"] = { "MORE", "inactive" },
        ["!"] = { "SHELL", "inactive" },
        ["niI"] = { "NORMAL", "normal" },
        ["niR"] = { "NORMAL", "normal" },
        ["niV"] = { "NORMAL", "normal" },
        ["R"] = { "REPLACE", "replace" },
        ["c"] = { "COMMAND", "command" },
        ["r"] = { "PROMPT", "inactive" },
        ["Rc"] = { "REPLACE", "replace" },
        ["Rx"] = { "REPLACE", "replace" },
        ["cv"] = { "COMMAND", "command" },
        ["ce"] = { "COMMAND", "command" },
        ["null"] = { "null", "inactive" },
        ["r?"] = { "CONFIRM", "inactive" },
        ["Rv"] = { "V-REPLACE", "replace" },
      },

      setup_colors = function()
        local astro = require("astrocore")
        local status_opts = require("astroui").config.status --[[@as AstroUIStatusOpts]]
        local lualine_mode = require("astroui.status.hl").lualine_mode

        local get_hlgroup = astro.get_hlgroup
        local color = assert(status_opts.fallback_colors)

        local function resolve_lualine(orig, ...) return (not orig or orig == "NONE") and lualine_mode(...) or orig end

        --! General
        local Error = get_hlgroup("Error", { fg = color.red, bg = color.bg })
        local Normal = get_hlgroup("Normal", { fg = color.fg, bg = color.bg })

        --! WinBar / TabLine / StatusLine
        local WinBarNC = get_hlgroup("WinBarNC", { fg = color.grey, bg = color.bg })
        local TabLine = get_hlgroup("TabLine", { fg = color.grey, bg = color.none })
        local WinBar = get_hlgroup("WinBar", { fg = color.bright_grey, bg = color.bg })
        local TabLineSel = get_hlgroup("TabLineSel", { fg = color.fg, bg = color.none })
        local StatusLine = get_hlgroup("StatusLine", { fg = color.fg, bg = color.dark_bg })
        local TabLineFill = get_hlgroup("TabLineFill", { fg = color.fg, bg = color.dark_bg })

        --! Syntax
        local String = get_hlgroup("String", { fg = color.green, bg = color.dark_bg })
        local Comment = get_hlgroup("Comment", { fg = color.bright_grey, bg = color.bg })
        local TypeDef = get_hlgroup("TypeDef", { fg = color.yellow, bg = color.dark_bg })
        local Conditional = get_hlgroup("Conditional", { fg = color.bright_purple, bg = color.dark_bg })
        local NvimEnvironmentName = get_hlgroup("NvimEnvironmentName", { fg = color.yellow, bg = color.dark_bg })

        --! GitSigns
        local GitSignsAdd = get_hlgroup("GitSignsAdd", { fg = color.green, bg = color.dark_bg })
        local GitSignsChange = get_hlgroup("GitSignsChange", { fg = color.orange, bg = color.dark_bg })
        local GitSignsDelete = get_hlgroup("GitSignsDelete", { fg = color.bright_red, bg = color.dark_bg })

        --! Diagnostic
        local DiagnosticInfo = get_hlgroup("DiagnosticInfo", { fg = color.white, bg = color.dark_bg })
        local DiagnosticWarn = get_hlgroup("DiagnosticWarn", { fg = color.orange, bg = color.dark_bg })
        local DiagnosticError = get_hlgroup("DiagnosticError", { fg = color.bright_red, bg = color.dark_bg })
        local DiagnosticHint = get_hlgroup("DiagnosticHint", { fg = color.bright_yellow, bg = color.dark_bg })

        --! Heirline
        local HeirlineNormal = resolve_lualine(get_hlgroup("HeirlineNormal", { bg = nil }).bg, "normal", color.blue)
        local HeirlineInsert = resolve_lualine(get_hlgroup("HeirlineInsert", { bg = nil }).bg, "insert", color.green)
        local HeirlineVisual = resolve_lualine(get_hlgroup("HeirlineVisual", { bg = nil }).bg, "visual", color.purple)

        local HeirlineTerminal =
          resolve_lualine(get_hlgroup("HeirlineTerminal", { bg = nil }).bg, "insert", HeirlineInsert)
        local HeirlineInactive =
          resolve_lualine(get_hlgroup("HeirlineInactive", { bg = nil }).bg, "inactive", color.dark_grey)
        local HeirlineReplace =
          resolve_lualine(get_hlgroup("HeirlineReplace", { bg = nil }).bg, "replace", color.bright_red)
        local HeirlineCommand =
          resolve_lualine(get_hlgroup("HeirlineCommand", { bg = nil }).bg, "command", color.bright_yellow)

        local colors = {
          fg = StatusLine.fg,
          bg = StatusLine.bg,
          close_fg = Error.fg,
          tab_fg = TabLine.fg,
          tab_bg = TabLine.bg,
          winbar_fg = WinBar.fg,
          winbar_bg = WinBar.bg,
          scrollbar = TypeDef.fg,
          buffer_fg = Comment.fg,
          mode_fg = StatusLine.bg,
          tab_close_fg = Error.fg,
          normal = HeirlineNormal,
          insert = HeirlineInsert,
          visual = HeirlineVisual,
          treesitter_fg = String.fg,
          winbarnc_fg = WinBarNC.fg,
          winbarnc_bg = WinBarNC.bg,
          replace = HeirlineReplace,
          command = HeirlineCommand,
          section_fg = StatusLine.fg,
          section_bg = StatusLine.bg,
          git_added = GitSignsAdd.fg,
          buffer_bg = TabLineFill.bg,
          tabline_bg = TabLineFill.bg,
          tabline_fg = TabLineFill.bg,
          buffer_picker_fg = Error.fg,
          inactive = HeirlineInactive,
          terminal = HeirlineTerminal,
          buffer_path_fg = WinBarNC.fg,
          buffer_close_fg = Comment.fg,
          buffer_active_fg = Normal.fg,
          buffer_active_bg = Normal.bg,
          diag_WARN = DiagnosticWarn.fg,
          diag_INFO = DiagnosticInfo.fg,
          diag_HINT = DiagnosticHint.fg,
          buffer_visible_fg = Normal.fg,
          buffer_visible_bg = Normal.bg,
          tab_close_bg = TabLineFill.bg,
          tab_active_fg = TabLineSel.fg,
          tab_active_bg = TabLineSel.bg,
          git_branch_fg = Conditional.fg,
          git_changed = GitSignsChange.fg,
          git_removed = GitSignsDelete.fg,
          diag_ERROR = DiagnosticError.fg,
          buffer_overflow_fg = Comment.fg,
          buffer_active_close_fg = Error.fg,
          buffer_visible_close_fg = Error.fg,
          buffer_active_path_fg = WinBarNC.fg,
          buffer_overflow_bg = TabLineFill.bg,
          buffer_visible_path_fg = WinBarNC.fg,
          virtual_env_fg = NvimEnvironmentName.fg,
        }

        local user_colors = status_opts.colors
        if type(user_colors) == "table" then
          colors = astro.extend_tbl(colors, user_colors)
        elseif type(user_colors) == "function" then
          colors = user_colors(colors)
        end

        for _, section in ipairs({
          "lsp",
          "nav",
          "mode",
          "git_diff",
          "cmd_info",
          "file_info",
          "git_branch",
          "treesitter",
          "diagnostics",
          "virtual_env",
          "macro_recording",
        }) do
          if not colors[section .. "_bg"] then colors[section .. "_bg"] = colors["section_bg"] end
          if not colors[section .. "_fg"] then colors[section .. "_fg"] = colors["section_fg"] end
        end

        return colors
      end,
    }
  end,
}
