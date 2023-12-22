local settings = Andromeda.settings.options

local globals = {
  -- This file is automatically loaded by plugins.core
  mapleader = settings.mapleader, --- Map leader key
  maplocalleader = settings.maplocalleader, --- Map local leader key

  -- Enable LazyVim auto format
  autoformat = true,

  -- Fix markdown indentation settings
  markdown_recommended_style = 0,

  -- LazyVim root dir detection
  -- Each entry can be:
  -- * the name of a detector function like `lsp` or `cwd`
  -- * a pattern or array of patterns like `.git` or `lua`.
  -- * a function with signature `function(buf) -> string|string[]`
  root_spec = { "lsp", { ".git", "lua" }, "cwd" },
}

local options = {
  autowrite = true, -- Enable auto write
  clipboard = "unnamedplus", -- Sync with system clipboard
  completeopt = "menu,menuone,noselect",
  conceallevel = 3, -- Hide * markup for bold and italic
  confirm = settings.confirm, -- Confirm to save changes before exiting modified buffer
  cursorline = settings.cursorline, -- Enable highlighting of the current line
  expandtab = settings.expandtab, -- Use spaces instead of tabs
  -- Folding
  foldlevel = 99,
  foldtext = "v:lua.Andromeda.kit.ui.foldtext()",
  formatoptions = "jcroqlnt", -- tcqj
  fillchars = {
    foldopen = "",
    foldclose = "",
    -- fold = "⸱",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
  },
  grepformat = "%f:%l:%c:%m",
  ignorecase = true, -- Ignore case
  inccommand = "nosplit", -- preview incremental substitute
  laststatus = 3, -- global statusline
  list = settings.list, -- Show some invisible characters (tabs...
  mouse = settings.mouse, -- Enable mouse mode
  number = settings.number, -- Print line number
  pumblend = 10, -- Popup blend
  pumheight = 10, -- Maximum number of entries in a popup
  relativenumber = settings.relative_number, -- Relative line numbers
  scrolloff = 4, -- Lines of context
  sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
  shiftround = true, -- Round indent
  shiftwidth = 2, -- Size of an indent
  showmode = false, -- Dont show mode since we have a statusline
  showtabline = settings.showtabline, --- Always show tabs
  sidescrolloff = 8, -- Columns of context
  signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
  smartcase = true, -- Don't ignore case with capitals
  smartindent = true, -- Insert indents automatically
  spelllang = { "en" },
  splitbelow = true, -- Put new windows below current
  splitkeep = "screen",
  splitright = true, -- Put new windows right of current
  tabstop = 2, -- Number of spaces tabs count for
  termguicolors = true, -- True color support
  timeoutlen = settings.timeoutlen,
  undofile = true,
  undolevels = 10000,
  updatetime = 200, -- Save swap file and trigger CursorHold
  virtualedit = "block", -- Allow cursor to move where there is no text in visual block mode
  wildmode = "longest:full,full", -- Command-line completion mode
  winminwidth = 5, -- Minimum window width
  wrap = false, -- Disable line wrap
}

if settings.grepprg:is_not_empty() then
  options.grepprg = settings.grepprg
else
  options.grepprg = "rg --vimgrep"
end

vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- vim.o.formatexpr = "v:lua.Andromeda.kit.format.formatexpr()"
if vim.fn.has("nvim-0.10") == 1 then vim.opt.smoothscroll = true end
-- if vim.fn.has("nvim-0.9.0") == 1 then vim.opt.statuscolumn = [[%!v:lua.Andromeda.kit.ui.statuscolumn()]] end

-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.foldmethod = "expr"
  -- vim.opt.foldexpr = "v:lua.Andromeda.kit.ui.foldexpr()"
else
  vim.opt.foldmethod = "indent"
end

--! Apply globals
for k, v in pairs(globals) do
  vim.g[k] = v
end

--! Apply options
for k, v in pairs(options) do
  vim.opt[k] = v
end
