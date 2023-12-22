local astro = require("astrocore")
local icons = {
  ui = Andromeda.icons.ui.get,
  git = Andromeda.icons.git.get,
  documents = Andromeda.icons.documents.get,
}

return {
  close_if_last_window = true,
  auto_clean_after_session_restore = true,

  window = {
    width = 30,
    mappings = {
      O = "system_open",
      Y = "copy_selector",
      l = "child_or_open",
      h = "parent_or_close",
      ["[b"] = "prev_source",
      ["]b"] = "next_source",
      ["<S-CR>"] = "system_open",
      F = astro.is_available("telescope.nvim") and "find_in_dir" or nil,
      ["<Space>"] = false, -- disable space until we figure out which-key disabling
    },
    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
      ["<C-k>"] = "move_cursor_up",
      ["<C-j>"] = "move_cursor_down",
    },
  },

  filesystem = {
    use_libuv_file_watcher = true,
    hijack_netrw_behavior = "open_current",
    follow_current_file = { enabled = true },
  },

  sources = { "filesystem", "buffers", "git_status" },
  source_selector = {
    winbar = true,
    content_layout = "center",
    sources = {
      { source = "filesystem", display_name = icons.documents("Folder", 1, true) .. "File" },
      { source = "buffers", display_name = icons.documents("Default", 1, true) .. "Bufs" },
      { source = "git_status", display_name = icons.git("Git", 1, true) .. "Git" },
      { source = "diagnostics", display_name = icons.ui("Diagnostic", 1, true) .. "Diagnostic" },
    },
  },

  default_component_configs = {
    indent = { padding = 0 },
    modified = { symbol = icons.documents("FileModified") },

    icon = {
      default = icons.documents("Default"),
      folder_closed = icons.documents("Folder"),
      folder_open = icons.documents("FolderOpen"),
      folder_empty = icons.documents("EmptyFolder"),
      folder_empty_open = icons.documents("EmptyFolderOpen"),
    },

    git_status = {
      symbols = {
        added = icons.git("Add"),
        staged = icons.git("Staged"),
        deleted = icons.git("Delete"),
        modified = icons.git("Change"),
        renamed = icons.git("Renamed"),
        ignored = icons.git("Ignored"),
        unstaged = icons.git("Unstaged"),
        conflict = icons.git("Conflict"),
        untracked = icons.git("Untracked"),
      },
    },
  },

  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function(_) vim.opt_local.signcolumn = "auto" end,
    },
  },

  commands = {
    system_open = function(state)
      -- TODO: remove deprecated method check after dropping support for neovim v0.9
      (vim.ui.open or astro.system_open)(state.tree:get_node():get_id())
    end,

    parent_or_close = function(state)
      local node = state.tree:get_node()
      if (node.type == "directory" or node:has_children()) and node:is_expanded() then
        state.commands.toggle_node(state)
      else
        require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
      end
    end,

    child_or_open = function(state)
      local node = state.tree:get_node()
      if node.type == "directory" or node:has_children() then
        if not node:is_expanded() then -- if unexpanded, expand
          state.commands.toggle_node(state)
        else -- if expanded and has children, seleect the next child
          require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
        end
      else -- if not a directory just open it
        state.commands.open(state)
      end
    end,

    copy_selector = function(state)
      local node = state.tree:get_node()
      local filepath = node:get_id()
      local filename = node.name
      local modify = vim.fn.fnamemodify

      local vals = {
        ["BASENAME"] = modify(filename, ":r"),
        ["EXTENSION"] = modify(filename, ":e"),
        ["FILENAME"] = filename,
        ["PATH (CWD)"] = modify(filepath, ":."),
        ["PATH (HOME)"] = modify(filepath, ":~"),
        ["PATH"] = filepath,
        ["URI"] = vim.uri_from_fname(filepath),
      }

      local options = vim.tbl_filter(function(val) return vals[val] ~= "" end, vim.tbl_keys(vals))
      if vim.tbl_isempty(options) then
        astro.notify("No values to copy", vim.log.levels.WARN)
        return
      end
      table.sort(options)
      vim.ui.select(options, {
        prompt = "Choose to copy to clipboard:",
        format_item = function(item) return ("%s: %s"):format(item, vals[item]) end,
      }, function(choice)
        local result = vals[choice]
        if result then
          astro.notify(("Copied: `%s`"):format(result))
          vim.fn.setreg("+", result)
        end
      end)
    end,
    find_in_dir = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      require("telescope.builtin").find_files({
        cwd = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h"),
      })
    end,
  },
}
