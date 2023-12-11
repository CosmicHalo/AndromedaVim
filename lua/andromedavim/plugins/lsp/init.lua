return {
  {
    "neovim/nvim-lspconfig",
    event = "User AndromedaFile",
    cmd = function(_, cmds) -- HACK: lazy load lspconfig on `:Neoconf` if neoconf is available
      if require("astrocore").is_available "neoconf.nvim" then table.insert(cmds, "Neoconf") end
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
            cond = function() return vim.fn.exists ":LspInfo" > 0 end,
          }
        end,
      },
    },

    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options?
      ---@diagnostic disable-next-line: missing-fields
      servers = {
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },

      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string|integer,fun(server:string,opts:_.lspconfig.options)|boolean?>
      handlers = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },

    ---@param opts PluginLspOpts
    config = function(_, opts)
      local astrolsp = require "astrolsp"
      local astrocore = require "astrocore"
      local Lib = require "andromedavim.libs"

      if astrocore.is_available "neoconf.nvim" then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end

      -- setup autoformat
      Lib.format.register(Lib.lsp.formatter())

      --! Copy over servers, configs, and handlers from opts
      for server, server_opts in pairs(opts.servers) do
        astrolsp.config.servers = vim.list_extend(astrolsp.config.servers, { server })
        astrolsp.config.config = astrocore.extend_tbl(astrolsp.config.config, { [server] = server_opts })
      end

      -- Copy over servers, handlers, and configs
      astrolsp.config.handlers = astrocore.extend_tbl(astrolsp.config.handlers, opts.handlers)

      local setup_servers = function()
        vim.tbl_map(require("astrolsp").lsp_setup, astrolsp.config.servers)
        vim.api.nvim_exec_autocmds("FileType", {})
        require("andromedavim.libs").event "LspSetup"
      end

      vim.defer_fn(function()
        if astrocore.is_available "mason-lspconfig.nvim" then
          astrocore.on_load("mason-lspconfig.nvim", setup_servers)
        else
          setup_servers()
        end
      end, 0)

      --! Setup Deno over TSServer
      if Lib.lsp.get_config "denols" and Lib.lsp.get_config "tsserver" then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        Lib.lsp.disable("tsserver", is_deno)
        Lib.lsp.disable("denols", function(root_dir) return not is_deno(root_dir) end)
      end
    end,
  },
}
