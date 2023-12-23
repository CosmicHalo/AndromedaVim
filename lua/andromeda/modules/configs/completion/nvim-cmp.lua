return function(_, _)
  local snip_status_ok, luasnip = pcall(require, "luasnip")
  if not snip_status_ok then return end

  local cmp = require("cmp")
  local astro = require("astrocore")
  local defaults = require("cmp.config.default")()
  local lspkind_status_ok, lspkind = pcall(require, "lspkind")

  local border_opts = {
    border = Andromeda.settings.ui.float.border,
    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
  }

  local function has_words_before()
    local line, col = (table.unpack)(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  return {
    enabled = function()
      -- add interoperability with cmp-dap
      local dap_prompt = astro.is_available("cmp-dap")
        and vim.tbl_contains({ "dap-repl", "dapui_watches", "dapui_hover" }, vim.bo[0].filetype)
      if vim.bo[0].buftype == "prompt" and not dap_prompt then return false end

      ---@diagnostic disable-next-line: undefined-field
      if vim.b.cmp_enabled == nil then
        return require("astrocore").config.features.cmp
      else
        ---@diagnostic disable-next-line: undefined-field
        return vim.b.cmp_enabled
      end
    end,

    sorting = defaults.sorting,
    preselect = cmp.PreselectMode.Item,
    completion = { completeopt = "menu,menuone,noinsert" },
    experimental = { ghost_text = { hl_group = "CmpGhostText" } },
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },

    confirm_opts = {
      select = false,
      behavior = cmp.ConfirmBehavior.Replace,
    },

    duplicates = {
      path = 1,
      buffer = 1,
      luasnip = 1,
      nvim_lsp = 1,
      cmp_tabnine = 1,
    },

    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = lspkind_status_ok and lspkind.cmp_format(astro.plugin_opts("lspkind.nvim")) or nil,
    },

    window = {
      completion = cmp.config.window.bordered(border_opts),
      documentation = cmp.config.window.bordered(border_opts),
    },

    mapping = {
      ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable,
      ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 750 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
    }),
  }
end
