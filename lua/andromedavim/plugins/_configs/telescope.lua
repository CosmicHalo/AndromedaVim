Andromeda.mappings.telescope = function(_, opts)
  local astro = require("astrocore")

  local maps = opts.mappings
  local is_available = astro.is_available

  --! Git
  maps.n["<Leader>g"] = opts._map_section.g
  maps.n["<Leader>gt"] = {
    function() require("telescope.builtin").git_status({ use_file_path = true }) end,
    desc = "Git status",
  }
  maps.n["<Leader>gc"] = {
    function() require("telescope.builtin").git_commits({ use_file_path = true }) end,
    desc = "Git commits (repository)",
  }
  maps.n["<Leader>gb"] = {
    function() require("telescope.builtin").git_branches({ use_file_path = true }) end,
    desc = "Git branches",
  }
  maps.n["<Leader>gC"] = {
    function() require("telescope.builtin").git_bcommits({ use_file_path = true }) end,
    desc = "Git commits (current file)",
  }

  --! Find / Search
  maps.n["<Leader>f"] = opts._map_section.f
  maps.n["<Leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
  maps.n["<Leader>fF"] = {
    function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end,
    desc = "Find all files",
  }
  maps.n["<Leader>fw"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" }
  maps.n["<Leader>fW"] = {
    function()
      require("telescope.builtin").live_grep({
        additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
      })
    end,
    desc = "Find words in all files",
  }
  maps.n["<Leader>fc"] = {
    function() require("telescope.builtin").grep_string() end,
    desc = "Find word under cursor",
  }
  maps.n["<Leader>fC"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" }

  maps.n["<Leader>f<CR>"] = {
    function() require("telescope.builtin").resume() end,
    desc = "Resume previous search",
  }
  maps.n["<Leader>f'"] = {
    function() require("telescope.builtin").marks() end,
    desc = "Find marks",
  }
  maps.n["<Leader>f/"] = {
    function() require("telescope.builtin").current_buffer_fuzzy_find() end,
    desc = "Find words in current buffer",
  }
  maps.n["<Leader>fa"] = {
    function()
      require("telescope.builtin").find_files({
        prompt_title = "Config Files",
        cwd = vim.fn.stdpath("config"),
        follow = true,
      })
    end,
    desc = "Find Andromeda config files",
  }

  maps.n["<Leader>fm"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
  maps.n["<Leader>fh"] = { function() require("telescope.builtin").help_tags() end, desc = "Find help" }
  maps.n["<Leader>fb"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffers" }
  maps.n["<Leader>fk"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" }
  maps.n["<Leader>fo"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" }
  maps.n["<Leader>fr"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }

  maps.n["<Leader>ft"] = {
    function() require("telescope.builtin").colorscheme({ enable_preview = true }) end,
    desc = "Find themes",
  }
  maps.n["<Leader>ls"] = {
    function()
      if is_available("aerial.nvim") then
        require("telescope").extensions.aerial.aerial()
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end,
    desc = "Search symbols",
  }

  if is_available("nvim-notify") then
    maps.n["<Leader>fn"] = {
      function() require("telescope").extensions.notify.notify() end,
      desc = "Find notifications",
    }
  end
end
