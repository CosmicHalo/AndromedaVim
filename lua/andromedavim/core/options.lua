vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable andromeda auto format
vim.g.autoformat = true
vim.g.icons_enabled = true
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"

-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.backspace:append({ "nostop" }) -- don't stop backspace at insert
opt.breakindent = true -- wrap indent to match  line start
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.cmdheight = 0 -- hide command line unless needed
opt.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.copyindent = true -- copy the previous indentation on autoindenting
opt.cursorline = true -- Enable highlighting of the current line
opt.diffopt:append({ "algorithm:histogram", "linematch:60" }) -- enable linematch diff algorithm
opt.expandtab = true -- enable the use of space in tab
opt.fileencoding = "utf-8" -- file content encoding for the buffer
opt.fillchars = { eob = " " } -- disable `~` on nonexistent lines
opt.foldcolumn = "1" -- show foldcolumn
opt.foldenable = true -- enable fold for nvim-ufo
opt.foldlevel = 99 -- set high foldlevel for nvim-ufo
opt.foldlevelstart = 99 -- start with all code unfolded
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.history = 100 -- number of commands to remember in a history table
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.infercase = true -- infer cases in keyword completion
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- wrap lines at 'breakat'
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.preserveindent = true -- preserve indent structure as much as possible
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = false -- show relative numberline
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.showtabline = 2 -- always display tabline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.viewoptions:remove("curdir") -- disable saving current directory with views
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.writebackup = false -- disable making a backup before overwriting a file

if vim.fn.has("nvim-0.10") == 1 then opt.smoothscroll = true end

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldtext = "v:lua.Andromeda.lib.ui.foldtext()"

if vim.fn.has("nvim-0.9.0") == 1 then vim.opt.statuscolumn = [[%!v:lua.Andromeda.lib.ui.statuscolumn()]] end

-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.Andromeda.lib.ui.foldexpr()"
else
  vim.opt.foldmethod = "indent"
end

vim.o.formatexpr = "v:lua.Andromeda.lib.format.formatexpr()"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

---@diagnostic disable-next-line: inject-field
if not vim.t.bufs then vim.t.bufs = vim.api.nvim_list_bufs() end -- initialize buffer list

if type(vim.g.andromeda_options) == "function" then vim.g.andromeda_options() end
