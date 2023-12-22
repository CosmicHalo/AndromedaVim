return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astro = require("astrocore")
    local andromeda_buffers = require("astrocore.buffer")
    local andromeda_toggles = require("astrocore.toggles")

    local icons = {
      ui = Andromeda.icons.ui.get,
      git = Andromeda.icons.git.get,
      lsp = Andromeda.icons.lsp.get,
      misc = Andromeda.icons.misc.get,
    }

    -- initialize internally use mapping section titles
    ---@diagnostic disable-next-line: inject-field
    opts._map_sections = {
      g = { desc = icons.git("Git") .. "Git" },
      f = { desc = icons.ui("Search") .. "Find" },
      b = { desc = icons.ui("Tab") .. "Buffers" },
      u = { desc = icons.misc("Window") .. "UI/UX" },
      p = { desc = icons.ui("Package") .. "Packages" },
      d = { desc = icons.ui("Debugger") .. "Debugger" },
      S = { desc = icons.misc("Session") .. "Session" },
      bs = { desc = icons.ui("Sort") .. "Sort Buffers" },
      t = { desc = icons.misc("Terminal") .. "Terminal" },
      l = { desc = icons.lsp("ActiveLSP") .. "Language Tools" },
    }

    -- initialize mappings table
    local maps = astro.empty_map_table()
    local sections = assert(opts._map_sections)

    -- Normal --

    -- Standard Operations

    maps.n["<C-q>"] = { "<Cmd>q!<CR>", desc = "Force quit" }
    maps.n["<C-s>"] = { "<Cmd>w!<CR>", desc = "Force write" }

    maps.n["|"] = { "<Cmd>vsplit<CR>", desc = "Vertical Split" }
    maps.n["\\"] = { "<Cmd>split<CR>", desc = "Horizontal Split" }

    maps.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move cursor up" }
    maps.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move cursor down" }

    maps.n["<Leader>w"] = { "<Cmd>w<CR>", desc = "Save" }
    maps.n["<Leader>N"] = { "<Cmd>enew<CR>", desc = "New File" }
    maps.n["<Leader>q"] = { "<Cmd>confirm q<CR>", desc = "Quit" }
    maps.n["<Leader>Q"] = { "<Cmd>confirm qall<CR>", desc = "Quit all" }

    -- TODO: remove deprecated method check after dropping support for neovim v0.9
    if not vim.ui.open then
      maps.n["gx"] = { astro.system_open, desc = "Open the file under cursor with system app" }
    end

    --! Section for managing plugins
    maps.n["<Leader>p"] = vim.tbl_get(sections, "p")
    maps.n["<Leader>pi"] = { function() require("lazy").install() end, desc = "Plugins Install" }
    maps.n["<Leader>ps"] = { function() require("lazy").home() end, desc = "Plugins Status" }
    maps.n["<Leader>pS"] = { function() require("lazy").sync() end, desc = "Plugins Sync" }
    maps.n["<Leader>pu"] = { function() require("lazy").check() end, desc = "Plugins Check Updates" }
    maps.n["<Leader>pU"] = { function() require("lazy").update() end, desc = "Plugins Update" }
    maps.n["<Leader>pa"] = { function() astro.update_packages() end, desc = "Update Lazy and Mason" }

    --! Section for managing buffers
    maps.n["<Leader>b"] = vim.tbl_get(sections, "b")
    maps.n["<Leader>bc"] = {
      function() andromeda_buffers.close_all(true) end,
      desc = "Close all buffers except current",
    }
    maps.n["<Leader>bp"] = { function() andromeda_buffers.prev() end, desc = "Previous buffer" }

    -->>>>>> Buffer Sorting <<<<<<--
    maps.n["<Leader>bs"] = vim.tbl_get(sections, "bs")
    maps.n["<Leader>bse"] = { function() andromeda_buffers.sort("extension") end, desc = "By extension" }
    maps.n["<Leader>bsp"] = { function() andromeda_buffers.sort("full_path") end, desc = "By full path" }
    maps.n["<Leader>bsi"] = { function() andromeda_buffers.sort("bufnr") end, desc = "By buffer number" }
    maps.n["<Leader>bsm"] = { function() andromeda_buffers.sort("modified") end, desc = "By modification" }
    maps.n["<Leader>bsr"] = { function() andromeda_buffers.sort("unique_path") end, desc = "By relative path" }

    -->>>>>> Close Buffers <<<<<<--
    maps.n["<Leader>c"] = { function() andromeda_buffers.close() end, desc = "Close buffer" }
    maps.n["<Leader>bC"] = { function() andromeda_buffers.close_all() end, desc = "Close all buffers" }
    maps.n["<Leader>C"] = { function() andromeda_buffers.close(0, true) end, desc = "Force close buffer" }
    maps.n["<Leader>bl"] = { function() andromeda_buffers.close_left() end, desc = "Close all buffers to the left" }
    maps.n["<Leader>br"] = { function() andromeda_buffers.close_right() end, desc = "Close all buffers to the right" }

    maps.n["]b"] = {
      function() andromeda_buffers.nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    }
    maps.n["[b"] = {
      function() andromeda_buffers.nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    }
    maps.n[">b"] = {
      function() andromeda_buffers.move(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Move buffer tab right",
    }
    maps.n["<b"] = {
      function() andromeda_buffers.move(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Move buffer tab left",
    }

    --! Section for Diagnostics
    maps.n["<Leader>l"] = vim.tbl_get(sections, "l")
    maps.n["<Leader>ld"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }
    maps.n["[d"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" }
    maps.n["]d"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" }
    maps.n["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }

    --! Navigate tabs
    maps.n["]t"] = { function() vim.cmd.tabnext() end, desc = "Next tab" }
    maps.n["[t"] = { function() vim.cmd.tabprevious() end, desc = "Previous tab" }

    --! Section for managing toggles
    -- Custom menu for modification of the user experience
    maps.n["<Leader>u"] = vim.tbl_get(sections, "u")
    maps.n["<Leader>uw"] = { function() andromeda_toggles.wrap() end, desc = "Toggle wrap" }
    maps.n["<Leader>uS"] = { function() andromeda_toggles.conceal() end, desc = "Toggle conceal" }
    maps.n["<Leader>ut"] = { function() andromeda_toggles.tabline() end, desc = "Toggle tabline" }
    maps.n["<Leader>up"] = { function() andromeda_toggles.paste() end, desc = "Toggle paste mode" }
    maps.n["<Leader>us"] = { function() andromeda_toggles.spell() end, desc = "Toggle spellcheck" }
    maps.n["<Leader>ub"] = { function() andromeda_toggles.background() end, desc = "Toggle background" }
    maps.n["<Leader>ug"] = { function() andromeda_toggles.signcolumn() end, desc = "Toggle signcolumn" }
    maps.n["<Leader>uh"] = { function() andromeda_toggles.foldcolumn() end, desc = "Toggle foldcolumn" }
    maps.n["<Leader>ui"] = { function() andromeda_toggles.indent() end, desc = "Change indent setting" }
    maps.n["<Leader>ul"] = { function() andromeda_toggles.statusline() end, desc = "Toggle statusline" }
    maps.n["<Leader>un"] = { function() andromeda_toggles.number() end, desc = "Change line numbering" }
    maps.n["<Leader>uu"] = { function() andromeda_toggles.url_match() end, desc = "Toggle URL highlight" }
    maps.n["<Leader>uN"] = { function() andromeda_toggles.notifications() end, desc = "Toggle Notifications" }
    maps.n["<Leader>uy"] = { function() andromeda_toggles.buffer_syntax() end, desc = "Toggle syntax highlight" }

    -- Split navigation
    maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
    maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
    maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
    maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
    maps.n["<C-Up>"] = { "<Cmd>resize -2<CR>", desc = "Resize split up" }
    maps.n["<C-Down>"] = { "<Cmd>resize +2<CR>", desc = "Resize split down" }
    maps.n["<C-Left>"] = { "<Cmd>vertical resize -2<CR>", desc = "Resize split left" }
    maps.n["<C-Right>"] = { "<Cmd>vertical resize +2<CR>", desc = "Resize split right" }

    -- Stay in indent mode
    maps.v["<S-Tab>"] = { "<gv", desc = "Unindent line" }
    maps.v["<Tab>"] = { ">gv", desc = "Indent line" }

    -- Improved Terminal Navigation
    maps.t["<C-h>"] = { "<Cmd>wincmd h<CR>", desc = "Terminal left window navigation" }
    maps.t["<C-j>"] = { "<Cmd>wincmd j<CR>", desc = "Terminal down window navigation" }
    maps.t["<C-k>"] = { "<Cmd>wincmd k<CR>", desc = "Terminal up window navigation" }
    maps.t["<C-l>"] = { "<Cmd>wincmd l<CR>", desc = "Terminal right window navigation" }

    opts.mappings = maps
  end,
}
