Andromeda.mappings.toggleterm = function(_, opts)
  local maps = opts.mappings
  local astro = require("astrocore")

  maps.n["<Leader>t"] = opts._map_section.t

  --! Lazygit
  if vim.fn.executable("lazygit") == 1 then
    maps.n["<Leader>g"] = opts._map_section.g
    maps.n["<Leader>gg"] = {
      function()
        local worktree = astro.file_worktree()
        local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir) or ""
        astro.toggle_term_cmd("lazygit " .. flags)
      end,
      desc = "ToggleTerm lazygit",
    }
    maps.n["<Leader>tl"] = maps.n["<Leader>gg"]
  end

  --! Nodejs
  if vim.fn.executable("node") == 1 then
    maps.n["<Leader>tn"] = { function() astro.toggle_term_cmd("node") end, desc = "ToggleTerm node" }
  end

  --! GDU
  if vim.fn.executable("gdu") == 1 then
    maps.n["<Leader>tu"] = { function() astro.toggle_term_cmd("gdu") end, desc = "ToggleTerm gdu" }
  end

  --! Btm
  if vim.fn.executable("btm") == 1 then
    maps.n["<Leader>tt"] = { function() astro.toggle_term_cmd("btm") end, desc = "ToggleTerm btm" }
  end

  --! Python
  local python = vim.fn.executable("python") == 1 and "python" or vim.fn.executable("python3") == 1 and "python3"
  if python then maps.n["<Leader>tp"] = { function() astro.toggle_term_cmd(python) end, desc = "ToggleTerm python" } end

  --! General
  maps.n["<Leader>tf"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
  maps.n["<Leader>tv"] = { "<Cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "ToggleTerm vertical split" }
  maps.n["<Leader>th"] = {
    "<Cmd>ToggleTerm size=10 direction=horizontal<CR>",
    desc = "ToggleTerm horizontal split",
  }

  maps.n["<F7>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" }
  maps.t["<F7>"] = maps.n["<F7>"]
  maps.n["<C-'>"] = maps.n["<F7>"] -- requires terminal that supports binding <C-'>
  maps.t["<C-'>"] = maps.n["<F7>"] -- requires terminal that supports binding <C-'>
end
