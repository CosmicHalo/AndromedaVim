local FILE_TREES = {
  ["none"] = "none",
  ["neo-tree"] = "neo-tree",
  ["nvim-tree"] = "nvim-tree",
}

local tree_type = {}
local filetree = Andromeda.settings.plugins.file_tree

if filetree == FILE_TREES["neo-tree"] then
  tree_type = {
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "main", --! HACK: force neo-tree to checkout `main` for initial v3 migration since default branch has changed
      cmd = "Neotree",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
      },
      opts = require("configs.file-tree.neotree"),
    },
  }
elseif filetree == FILE_TREES["nvim-tree"] then
  tree_type = {
    "nvim-tree/nvim-tree.lua",
    event = "BufWinEnter",
    cmd = {
      "NvimTreeOpen",
      "NvimTreeClose",
      "NvimTreeToggle",
      "NvimTreeRefresh",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
    },
    dependencies = {
      Andromeda.kit.add_mappings({
        ["<Leader>e"] = { "<Cmd>NvimTreeToggle<CR>", desc = "Toggle Explorer" },
        ["<Leader>o"] = {
          function()
            if vim.bo.filetype == "NvimTree" then
              vim.cmd.wincmd("p")
            else
              vim.cmd("NvimTreeFocus")
            end
          end,
          desc = "Toggle Explorer Focus",
        },
      }),
    },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true -- set termguicolors to enable highlight groups
    end,
    opts = require("configs.file-tree.nvimtree"),
  }
end

return tree_type
