return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "markdown", "markdown_inline" }) end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts) Andromeda.lib.extend_list_opt(opts, { "markdownlint", "marksman" }) end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function() vim.cmd([[do FileType]]) end,
  },

  {
    "lukas-reineke/headlines.nvim",
    ft = { "markdown", "norg", "rmd", "org" },
    opts = function()
      local opts = {}
      for _, ft in ipairs({ "markdown", "norg", "rmd", "org" }) do
        opts[ft] = {
          headline_highlights = {},
        }
        for i = 1, 6 do
          local hl = "Headline" .. i
          vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
          table.insert(opts[ft].headline_highlights, hl)
        end
      end
      return opts
    end,
    config = function(_, opts)
      -- PERF: schedule to prevent headlines slowing down opening a file
      vim.schedule(function()
        require("headlines").setup(opts)
        require("headlines").refresh()
      end)
    end,
  },
}
