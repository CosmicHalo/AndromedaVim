local deps = {
  -- HACK: remove when https://github.com/windwp/nvim-ts-autotag/issues/125 closed.
  {
    "windwp/nvim-ts-autotag",
    opts = {
      enable = true,
      line_numbers = true,
      enable_close_on_slash = false,

      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'

      zindex = 30,
      max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line

      filetypes = {
        "lua",
        "html",
        "javascript",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "xml",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = require("configs.treesitter").textobjects,
  },
}

local treesitter_ctx = {}

if Andromeda.settings.plugins.enable_treesitter_context then
  treesitter_ctx = {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "User AndromedaFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
    config = function()
      require("treesitter-context").setup({
        zindex = 20,
        enable = true,
        max_lines = 0,
        mode = "cursor",
        separator = nil,
        on_attach = nil,
        line_numbers = true,
        trim_scope = "outer",
        min_window_height = 0,
        multiline_threshold = 20,
      })
    end,
  }
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    dependencies = deps,
    event = { "User AndromedaFile", "VeryLazy" },
    cmd = {
      "TSBufDisable",
      "TSBufEnable",
      "TSBufToggle",
      "TSDisable",
      "TSEnable",
      "TSToggle",
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSModuleInfo",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only thins that those plugins need are the custom queries, which we make available
      -- during startup.
      -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    config = require("configs.treesitter").treesitter,
  },

  {
    "Wansmer/treesj",
    cmd = { "TSJToggle", "TSJJoin", "TSJSplit" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      Andromeda.kit.add_mappings({
        ["<leader>tj"] = { "<CMD>TSJJoin<CR>", desc = "Treesitter Join" },
        ["<leader>ts"] = { "<CMD>TSJSplit<CR>", desc = "Treesitter Split" },
        ["<leader>tt"] = { "<CMD>TSJToggle<CR>", desc = "Toggle Treesitter Join" },
      }),
    },
    config = function() require("treesj").setup({ use_default_keymaps = false }) end,
  },

  treesitter_ctx,
}
