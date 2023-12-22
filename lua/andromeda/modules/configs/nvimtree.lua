Andromeda.mappings.nvimtree = function(_, opts)
  local maps = opts.mappings

  maps.n["<Leader>e"] = { "<Cmd>NvimTreeToggle<CR>", desc = "Toggle Explorer" }
  maps.n["<Leader>o"] = {
    function()
      if vim.bo.filetype == "NvimTree" then
        vim.cmd.wincmd("p")
      else
        vim.cmd("NvimTreeFocus")
      end
    end,
    desc = "Toggle Explorer Focus",
  }
end
