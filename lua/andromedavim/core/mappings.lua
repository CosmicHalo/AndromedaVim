local get_icon = require("astroui").get_icon

local M = {}

--!>>>>>>>>> conform-nvim <<<<<<<<<
M.conform_nvim = function(_, opts)
  -- local maps = opts.mappings
  -- maps.n["<leader>cF"] = {
  --   function() require("conform").format { formatters = { "injected" } } end,
  --   desc = "Format Injected Langs",
  -- }
end

--stylua: ignore
--!>>>>>>>>> Heirline <<<<<<<<<
M.heirline = function(_, opts)
  local maps = opts.mappings
  maps.n["<Leader>bb"] = {
    function() require("astroui.status.heirline").buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end) end,
    desc = "Select buffer from tabline",
  }
  maps.n["<Leader>bd"] = {
    function() require("astroui.status.heirline").buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end) end,
    desc = "Close buffer from tabline",
  }
  maps.n["<Leader>b\\"] = {
    function()
      require("astroui.status.heirline").buffer_picker(function(bufnr)
        vim.cmd.split()
        vim.api.nvim_win_set_buf(0, bufnr)
      end)
    end,
    desc = "Horizontal split buffer from tabline",
  }
  maps.n["<Leader>b|"] = {
    function()
      require("astroui.status.heirline").buffer_picker(function(bufnr)
        vim.cmd.vsplit()
        vim.api.nvim_win_set_buf(0, bufnr)
      end)
    end,
    desc = "Vertical split buffer from tabline",
  }
end

--!>>>>>>>>> Noice <<<<<<<<<
M.noice = function(_, opts)
  local maps = opts.mappings
  local noice = require "noice"

  maps.n["<leader>n"] = { desc = get_icon("Sparkle", 1, true) .. "Noice" }
  maps.n["<leader>na"] = { function() noice.cmd "all" end, desc = "Noice All" }
  maps.n["<leader>nd"] = { function() noice.cmd "dismiss" end, desc = "Dismiss All" }
  maps.n["<leader>nh"] = { function() noice.cmd "history" end, desc = "Noice History" }
  maps.n["<leader>nl"] = { function() noice.cmd "last" end, desc = "Noice Last Message" }
  maps.c["<S-Enter>"] = {
    function()
      noice.redirect(vim.fn.getcmdline() --[[@as string]])
    end,
    desc = "Redirect Cmdline",
  }
end

return M
