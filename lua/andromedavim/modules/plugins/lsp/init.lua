return {
  {
    "neovim/nvim-lspconfig",
    event = "User AndromedaFile",
    cmd = function(_, cmds) -- HACK: lazy load lspconfig on `:Neoconf` if neoconf is available
      if require("astrocore").is_available("neoconf.nvim") then table.insert(cmds, "Neoconf") end
      vim.list_extend(cmds, { "LspInfo", "LspLog", "LspStart" }) -- add normal `nvim-lspconfig` commands
    end,

    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },

      {
        "AstroNvim/astrolsp",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>li"] = {
            "<Cmd>LspInfo<CR>",
            desc = "LSP information",
            cond = function() return vim.fn.exists(":LspInfo") > 0 end,
          }
        end,
      },
    },

    config = function(_, opts)
      local astrolsp = require("astrolsp")
      local astrocore = require("astrocore")

      if astrocore.is_available("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end

      -- setup autoformat
      Andromeda.kit.format.register(Andromeda.kit.lsp.formatter())

      local setup_servers = function()
        vim.tbl_map(require("astrolsp").lsp_setup, astrolsp.config.servers)
        vim.api.nvim_exec_autocmds("FileType", {})
        Andromeda.kit.event("LspSetup")
      end

      vim.defer_fn(function()
        if astrocore.is_available("mason-lspconfig.nvim") then
          astrocore.on_load("mason-lspconfig.nvim", setup_servers)
        else
          setup_servers()
        end
      end, 0)

      --! Setup Deno over TSServer
      if Andromeda.kit.lsp.get_config("denols") and Andromeda.kit.lsp.get_config("tsserver") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        Andromeda.kit.lsp.disable("tsserver", is_deno)
        Andromeda.kit.lsp.disable("denols", function(root_dir) return not is_deno(root_dir) end)
      end
    end,
  },
}
