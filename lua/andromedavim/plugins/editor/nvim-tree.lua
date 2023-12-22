return {
  "nvim-tree/nvim-tree.lua",
  event = "BufWinEnter",
  cmd = {
    "NvimTreeOpen",
    "NvimTreeToggle",
    "NvimTreeRefresh",
    "NvimTreeFindFile",
    "NvimTreeFindFileToggle",
  },
  dependencies = { { "AstroNvim/astrocore", opts = Andromeda.mappings.nvimtree } },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true
  end,
  opts = function(_, opts)
    local icons = {
      ui = Andromeda.icons.ui,
      git = Andromeda.icons.git,
      documents = Andromeda.icons.documents,
      diagnostics = Andromeda.icons.diagnostics,
    }

    return {
      sort_by = "name",
      hijack_netrw = true,
      open_on_tab = false,
      hijack_cursor = true,
      disable_netrw = false,
      respect_buf_cwd = false,
      sync_root_with_cwd = true,
      auto_reload_on_write = true,
      create_in_closed_folder = false,
      hijack_unnamed_buffer_when_opening = true,

      trash = { cmd = "gio trash", require_confirm = true },
      live_filter = { prefix = "[FILTER]: ", always_show_folders = true },

      hijack_directories = { enable = true, auto_open = true },
      filesystem_watchers = { enable = true, debounce_delay = 50 },
      update_focused_file = { enable = true, update_root = true, ignore_list = {} },

      filters = {
        exclude = {},
        dotfiles = false,
        custom = { ".DS_Store" },
      },

      git = {
        timeout = 400,
        enable = true,
        ignore = false,
        show_on_dirs = true,
      },

      diagnostics = {
        enable = true,
        show_on_dirs = true,
        debounce_delay = 50,
        icons = {
          hint = icons.diagnostics.Hint_alt,
          error = icons.diagnostics.Error_alt,
          warning = icons.diagnostics.Warning_alt,
          info = icons.diagnostics.Information_alt,
        },
      },

      view = {
        width = 25,
        side = "left",
        number = false,
        signcolumn = "yes",
        adaptive_size = false,
        relativenumber = false,
        centralize_selection = false,
        preserve_window_proportions = false,

        float = {
          enable = false,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },

      actions = {
        use_system_clipboard = true,
        remove_file = { close_window = true },
        change_dir = { enable = true, global = false },

        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              buftype = { "terminal", "help" },
              filetype = { "notify", "qf", "diff", "fugitive", "fugitiveblame" },
            },
          },
        },
      },

      renderer = {
        full_name = false,
        group_empty = true,
        add_trailing = false,
        highlight_git = true,
        symlink_destination = true,
        highlight_opened_files = "none",
        root_folder_label = ":.:s?.*?/..?",
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },

        indent_markers = {
          enable = true,
          icons = {
            corner = "└ ",
            edge = "│ ",
            item = "│ ",
            none = "  ",
          },
        },

        icons = {
          padding = " ",
          webdev_colors = true,
          symlink_arrow = " 󰁔 ",
          git_placement = "after",

          show = {
            git = true,
            file = true,
            folder = true,
            folder_arrow = true,
          },

          glyphs = {
            default = icons.documents.Default,
            symlink = icons.documents.Symlink,
            bookmark = icons.documents.Bookmark,

            git = {
              unstaged = icons.git.Mod_alt,
              staged = icons.git.Add,
              unmerged = icons.git.Unmerged,
              renamed = icons.git.Rename,
              untracked = icons.git.Untracked,
              deleted = icons.git.Remove,
              ignored = icons.git.Ignore,
            },

            folder = {
              arrow_open = icons.ui.ArrowOpen,
              arrow_closed = icons.ui.ArrowClosed,
              -- arrow_open = "",
              -- arrow_closed = "",
              default = icons.ui.Folder,
              open = icons.ui.FolderOpen,
              empty = icons.ui.EmptyFolder,
              empty_open = icons.ui.EmptyFolderOpen,
              symlink = icons.ui.SymlinkFolder,
              symlink_open = icons.ui.FolderOpen,
            },
          },
        },
      },

      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          dev = false,
          git = false,
          config = false,
          profile = false,
          watcher = false,
          copy_paste = false,
          diagnostics = false,
        },
      },
    }
  end,
}
