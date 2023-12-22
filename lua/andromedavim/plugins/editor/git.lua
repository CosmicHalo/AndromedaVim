return {
  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  {
    "lewis6991/gitsigns.nvim",
    event = "User AndromedaGitFile",
    enabled = vim.fn.executable("git") == 1,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local gitsigns = require("gitsigns.actions")

          maps.n["<Leader>g"] = vim.tbl_get(opts._map_sections, "g")

          maps.n["<Leader>gs"] = { function() gitsigns.stage_hunk() end, desc = "Stage Git hunk" }
          maps.n["<Leader>gS"] = { function() gitsigns.stage_buffer() end, desc = "Stage Git buffer" }
          maps.n["<Leader>gr"] = { function() gitsigns.reset_buffer() end, desc = "Reset Git buffer" }

          maps.n["<Leader>gd"] = { function() gitsigns.diffthis() end, desc = "View Git diff" }
          maps.n["<Leader>gl"] = { function() gitsigns.blame_line() end, desc = "View Git blame" }
          maps.n["<Leader>gL"] = { function() gitsigns.blame_line({ full = true }) end, desc = "View full Git blame" }

          maps.n["[g"] = { function() gitsigns.prev_hunk() end, desc = "Previous Git hunk" }
          maps.n["]g"] = { function() gitsigns.next_hunk() end, desc = "Next Git hunk" }
          maps.n["<Leader>gh"] = { function() gitsigns.reset_hunk() end, desc = "Reset Git hunk" }
          maps.n["<Leader>gp"] = { function() gitsigns.preview_hunk_inline() end, desc = "Preview Git hunk" }
          maps.n["<Leader>gu"] = { function() gitsigns.undo_stage_hunk() end, desc = "Unstage Git hunk" }
        end,
      },
    },
    opts = function()
      return {
        sign_priority = 6,
        word_diff = false,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        current_line_blame = true,

        diff_opts = { internal = true },
        worktrees = require("astrocore").config.git_worktrees,
        watch_gitdir = { interval = 1000, follow_files = true },
        current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },

        signs = {
          add = {
            hl = "GitSignsAdd",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
            text = Andromeda.icons.git.Sign,
          },
          change = {
            hl = "GitSignsChange",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
            text = Andromeda.icons.git.Sign,
          },
          delete = {
            hl = "GitSignsDelete",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
            text = Andromeda.icons.git.Sign,
          },
          topdelete = {
            hl = "GitSignsDelete",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
            text = Andromeda.icons.git.Sign,
          },
          changedelete = {
            hl = "GitSignsChange",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
            text = Andromeda.icons.git.Sign,
          },
        },
      }
    end,
  },
}
