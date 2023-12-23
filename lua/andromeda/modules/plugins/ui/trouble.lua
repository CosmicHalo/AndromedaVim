local icons = {
  ui = Andromeda.icons.ui,
  diagnostics = Andromeda.icons.diagnostics,
}

return -- better diagnostics list and others
{
  "folke/trouble.nvim",
  cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
  opts = {
    width = 50, -- width of the list when position is left or right
    height = 10, -- height of the trouble list when position is top or bottom
    icons = true, -- use devicons for filenames
    use_diagnostic_signs = true, -- enabling this will use signs defined in your sign define

    position = "bottom", -- position of the list can be: bottom, top, left, right
    mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"

    fold_open = icons.ui.ArrowOpen, -- icon used for open folds
    fold_closed = icons.ui.ArrowClosed, -- icon used for closed folds

    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    indent_lines = true, -- add an indent guide below the fold icons
    auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result

    action_keys = {
      -- key mappings for actions in the trouble list
      -- map to {} to remove a mapping, for example:
      -- close = {},
      next = "j", -- next item
      close = "q", -- close the list
      previous = "k", -- preview item
      refresh = "r", -- manually refresh
      toggle_preview = "P", -- toggle auto_preview
      open_folds = { "zR", "zr" }, -- open all folds
      close_folds = { "zM", "zm" }, -- close all folds
      open_tab = { "<C-t>" }, -- open buffer in new tab
      preview = "p", -- preview the diagnostic location
      open_split = { "<C-x>" }, -- open buffer in new split
      open_vsplit = { "<C-v>" }, -- open buffer in new vsplit
      toggle_fold = { "zA", "za" }, -- toggle fold of current file
      jump_close = { "o" }, -- jump to the diagnostic and close the list
      hover = "K", -- opens a small popup with the full multiline message
      jump = { "<CR>", "<TAB>" }, -- jump to the diagnostic or open / close folds
      toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
      cancel = "<Esc>", -- cancel the preview and get back to your last window / buffer / cursor
    },

    signs = {
      -- icons / text used for a diagnostic
      hint = icons.diagnostics.Hint_alt,
      error = icons.diagnostics.Error_alt,
      other = icons.diagnostics.Question_alt,
      warning = icons.diagnostics.Warning_alt,
      information = icons.diagnostics.Information_alt,
    },
  },

  keys = {
    { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").previous({ skip_groups = true, jump = true })
        else
          ---@diagnostic disable-next-line: undefined-field
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then Andromeda.kit.notify(err, vim.log.levels.ERROR) end
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          ---@diagnostic disable-next-line: param-type-mismatch
          if not ok then Andromeda.kit.notify(err, vim.log.levels.ERROR) end
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },
}
