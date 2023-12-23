---@class AndromedaMappings
local M = Andromeda.mappings

--stylua: ignore


--!>>>>>>>>> Noice <<<<<<<<<

M.noice = function(_, opts)
  local maps = opts.mappings
  local noice = require("noice")

  maps.n["<leader>n"] = { desc = Andromeda.icons.misc.get("Sparkle") .. "Noice" }
  maps.n["<leader>na"] = { function() noice.cmd("all") end, desc = "Noice All" }
  maps.n["<leader>nd"] = { function() noice.cmd("dismiss") end, desc = "Dismiss All" }
  maps.n["<leader>nh"] = { function() noice.cmd("history") end, desc = "Noice History" }
  maps.n["<leader>nl"] = { function() noice.cmd("last") end, desc = "Noice Last Message" }
  maps.c["<S-Enter>"] = {
    function()
      noice.redirect(vim.fn.getcmdline() --[[@as string]])
    end,
    desc = "Redirect Cmdline",
  }
end

--!>>>>>>>>> Heirline <<<<<<<<<
M.heirline = function(_, opts)
  local maps = opts.mappings
  local astro_heirline = require("astroui.status.heirline")

  maps.n["<Leader>bb"] = {
    function()
      astro_heirline.buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)
    end,
    desc = "Select buffer from tabline",
  }

  maps.n["<Leader>bd"] = {
    function()
      astro_heirline.buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
    end,
    desc = "Close buffer from tabline",
  }

  maps.n["<Leader>b\\"] = {
    function()
      astro_heirline.buffer_picker(function(bufnr)
        vim.cmd.split()
        vim.api.nvim_win_set_buf(0, bufnr)
      end)
    end,
    desc = "Horizontal split buffer from tabline",
  }

  maps.n["<Leader>b|"] = {
    function()
      astro_heirline.buffer_picker(function(bufnr)
        vim.cmd.vsplit()
        vim.api.nvim_win_set_buf(0, bufnr)
      end)
    end,
    desc = "Vertical split buffer from tabline",
  }
end
