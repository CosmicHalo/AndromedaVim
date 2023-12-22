return function(_, opts)
  local astro = require("astrocore")
  local builtins = require("telescope.builtin")
  local extensions = require("telescope._extensions")

  local maps = opts.mappings
  local is_available = astro.is_available

  --! Git
  maps.n["<Leader>g"] = vim.tbl_get(opts._map_sections, "g")
  maps.n["<Leader>gt"] = { function() builtins.git_status({ use_file_path = true }) end, desc = "Git status" }
  maps.n["<Leader>gb"] = { function() builtins.git_branches({ use_file_path = true }) end, desc = "Git branches" }

  maps.n["<Leader>gc"] =
    { function() builtins.git_commits({ use_file_path = true }) end, desc = "Git commits (repository)" }
  maps.n["<Leader>gC"] =
    { function() builtins.git_bcommits({ use_file_path = true }) end, desc = "Git commits (current file)" }

  --! Find / Search
  maps.n["<Leader>f"] = vim.tbl_get(opts._map_sections, "f")
  maps.n["<Leader>ff"] = { function() builtins.find_files() end, desc = "Find files" }
  maps.n["<Leader>fF"] =
    { function() builtins.find_files({ hidden = true, no_ignore = true }) end, desc = "Find all files" }
  maps.n["<Leader>fw"] = { function() builtins.live_grep() end, desc = "Find words" }
  maps.n["<Leader>fW"] = {
    function()
      builtins.live_grep({
        additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
      })
    end,
    desc = "Find words in all files",
  }
  maps.n["<Leader>fC"] = { function() builtins.commands() end, desc = "Find commands" }
  maps.n["<Leader>fc"] = { function() builtins.grep_string() end, desc = "Find word under cursor" }

  maps.n["<Leader>f<CR>"] = { function() builtins.resume() end, desc = "Resume previous search" }
  maps.n["<Leader>f'"] = {
    function() builtins.marks() end,
    desc = "Find marks",
  }
  maps.n["<Leader>f/"] = {
    function() builtins.current_buffer_fuzzy_find() end,
    desc = "Find words in current buffer",
  }
  maps.n["<Leader>fa"] = {
    function()
      builtins.find_files({
        prompt_title = "Config Files",
        cwd = vim.fn.stdpath("config"),
        follow = true,
      })
    end,
    desc = "Find Andromeda config files",
  }

  maps.n["<Leader>fm"] = { function() builtins.man_pages() end, desc = "Find man" }
  maps.n["<Leader>fh"] = { function() builtins.help_tags() end, desc = "Find help" }
  maps.n["<Leader>fb"] = { function() builtins.buffers() end, desc = "Find buffers" }
  maps.n["<Leader>fk"] = { function() builtins.keymaps() end, desc = "Find keymaps" }
  maps.n["<Leader>fo"] = { function() builtins.oldfiles() end, desc = "Find history" }
  maps.n["<Leader>fr"] = { function() builtins.registers() end, desc = "Find registers" }

  maps.n["<Leader>ft"] = { function() builtins.colorscheme({ enable_preview = true }) end, desc = "Find themes" }
  maps.n["<Leader>ls"] = {
    function()
      if is_available("aerial.nvim") then
        local tele = require("telescope") --[[@as Telescope]]

        require("telescope") --[[@as Telescope]]
          .extensions
          .aerial
          .aerial()
      else
        builtins.lsp_document_symbols()
      end
    end,
    desc = "Search symbols",
  }

  if is_available("nvim-notify") then
    maps.n["<Leader>fn"] = {
      function()
        require("telescope") --[[@as Telescope]]
          .extensions
          .notify
          .notify()
      end,
      desc = "Find notifications",
    }
  end
end
