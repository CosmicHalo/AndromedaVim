return {
  {
    "neovim/nvim-lspconfig",
    event = "User AndromedaFile",
    cmd = function(_, cmds) -- HACK: lazy load lspconfig on `:Neoconf` if neoconf is available
      if require("astrocore").is_available "neoconf.nvim" then table.insert(cmds, "Neoconf") end
      vim.list_extend(cmds, { "LspInfo", "LspLog", "LspStart" }) -- add normal `nvim-lspconfig` commands
    end,

    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },

      {
        "AstroNvim/astrolsp",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>li"] =
            { "<Cmd>LspInfo<CR>", desc = "LSP information", cond = function() return vim.fn.exists ":LspInfo" > 0 end }
        end,
      },

      {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        opts = function(_, opts)
          if not opts.handlers then opts.handlers = {} end
          opts.handlers[1] = function(server) require("astrolsp").lsp_setup(server) end
        end,
      },
    },

    config = function(_, _)
      local astrocore = require "astrocore"
      local Lib = require "andromedavim.libs"

      -- setup autoformat
      Lib.format.register(Lib.lsp.formatter())

      local setup_servers = function()
        vim.tbl_map(require("astrolsp").lsp_setup, require("astrolsp").config.servers)
        vim.api.nvim_exec_autocmds("FileType", {})
        require("andromedavim.libs").event "LspSetup"
      end

      if astrocore.is_available "mason-lspconfig.nvim" then
        astrocore.on_load("mason-lspconfig.nvim", setup_servers)
      else
        setup_servers()
      end

      --! Setup Deno over TSServer
      if Lib.lsp.get_config "denols" and Lib.lsp.get_config "tsserver" then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        Lib.lsp.disable("tsserver", is_deno)
        Lib.lsp.disable("denols", function(root_dir) return not is_deno(root_dir) end)
      end
    end,
  },
}
