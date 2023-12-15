Andromeda.mappings.neotree = function(_, opts)
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
  opts.autocmds.neotree_start = {
    {
      event = "BufEnter",
      desc = "Open Neo-Tree on startup with directory",
      callback = function()
        if package.loaded["neo-tree"] then
          vim.api.nvim_del_augroup_by_name("neotree_start")
        else
          local stats = (vim.uv or vim.loop).fs_stat(vim.api.nvim_buf_get_name(0)) -- TODO: REMOVE vim.loop WHEN DROPPING SUPPORT FOR Neovim v0.9
          if stats and stats.type == "directory" then
            vim.api.nvim_del_augroup_by_name("neotree_start")
            require("neo-tree")
          end
        end
      end,
    },
  }
  opts.autocmds.neotree_refresh = {
    {
      event = "TermClose",
      pattern = "*lazygit",
      desc = "Refresh Neo-Tree sources when closing lazygit",
      callback = function()
        local manager_avail, manager = pcall(require, "neo-tree.sources.manager")
        if manager_avail then
          for _, source in ipairs({ "filesystem", "git_status", "document_symbols" }) do
            local module = "neo-tree.sources." .. source
            if package.loaded[module] then manager.refresh(require(module).name) end
          end
        end
      end,
    },
  }
end
