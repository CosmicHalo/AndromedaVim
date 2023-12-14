-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

---@enum (key) CmpIcons
local cmp = {
  -- Add source-specific icons here
  Codeium = "",
  Copilot = "",
  Copilot_alt = "",
  TabNine = "",
  buffer = "",
  cmp_tabnine = "",
  codeium = "",
  copilot = "",
  copilot_alt = "",
  latex_symbols = "",
  luasnip = "󰃐",
  nvim_lsp = "",
  nvim_lua = "",
  orgmode = "",
  path = "",
  spell = "󰓆",
  tmux = "",
  treesitter = "",
  undefined = "",
}

---@enum (key) TypeIcons
local type = {
  Array = "󰅪",
  Boolean = "",
  Null = "󰟢",
  Number = "",
  Object = "󰅩",
  String = "󰉿",
}

---@enum (key) KindIcons
local kind = {
  Class = "󰠱",
  Color = "󰏘",
  Constant = "󰏿",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "󰇽",
  File = "󰈙",
  Folder = "󰉋",
  Fragment = "",
  Function = "󰊕",
  Interface = "",
  Implementation = "",
  Keyword = "󰌋",
  Method = "󰆧",
  Module = "",
  Namespace = "󰌗",
  Number = "",
  Operator = "󰆕",
  Package = "",
  Property = "󰜢",
  Reference = "",
  Snippet = "",
  Struct = "",
  Text = "󰉿",
  TypeParameter = "󰅲",
  Undefined = "",
  Unit = "",
  Value = "󰎠",
  Variable = "",
  -- ccls-specific icons.
  TypeAlias = "",
  Parameter = "",
  StaticMethod = "",
  Macro = "",
}

---@enum (key) DapIcons
local dap = {
  Breakpoint = "󰝥",
  BreakpointCondition = "󰟃",
  BreakpointRejected = "",
  LogPoint = "",
  Pause = "",
  Play = "",
  RunLast = "↻",
  StepBack = "",
  StepInto = "󰆹",
  StepOut = "󰆸",
  StepOver = "󰆷",
  Stopped = "",
  Terminate = "󰝤",
}

---@enum (key) DiagnosticsIcons
local diagnostics = {
  Error = "",
  Hint = "󰌵",
  Information = "",
  Question = "",
  Warning = "",

  -- Holo version
  Error_alt = "󰅚",
  Hint_alt = "󰌶",
  Information_alt = "",
  Question_alt = "",
  Warning_alt = "󰀪",
}

---@enum (key) DocumentIcons
local documents = {
  Bookmark = "",
  Default = "",
  EmptyFolder = "",
  EmptyFolderOpen = "",
  File = "󰈙",
  FileModified = "✥",
  FileTree = "󰙅",
  Files = "",
  Folder = "",
  FolderOpen = "",
  FolderWithHeart = "󱃪",
  Import = "",
  NewFile = "",
  RootFolderOpened = "",
  Symlink = "",
  SymlinkFolder = "",
}

---@enum (key) GitIcons
local git = {
  Add = "",
  Branch = "",
  Change = "",
  Conflict = "",
  Delete = "",
  Diff = "",
  Git = "󰊢",
  Ignored = "",
  Mod = "M",
  Mod_alt = "",
  Removed = "",
  Renamed = "",
  Repo = "",
  Sign = "▎",
  Staged = "",
  Unmerged = "󰘬",
  Unstaged = "",
  Untracked = "󰞋",
}

---@enum (key) LSPIcons
local lsp = {
  ActiveLSP = "",
  ActiveTS = "",
  LSPLoading1 = "",
  LSPLoading2 = "󰀚",
  LSPLoading3 = "",
  LspAvailable = "󱜙",
  NoActiveLsp = "󱚧",
}

---@enum (key) MiscIcons
local misc = {
  Add = "+",
  Added = "",
  Campass = "󰀹",
  Code = "",
  Gavel = "",
  Ghost = "󰊠",
  Glass = "󰂖",
  Lazy = "󰒲",
  Lego = "",
  ManUp = "",
  Neovim = "",
  Power = "⏻",
  PyEnv = "󰢩",
  Rocket = "",
  Session = "󱂬",
  Sparkle = "",
  Squirrel = "",
  Tag = "",
  Terminal = "",
  Tree = "",
  Vbar = "│",
  Vim = "",
  Watch = "",
  Window = "",
}

---@enum (key) UIIcons
local ui = {
  Accepted = "",
  ArrowClosed = "",
  ArrowOpen = "",
  BigCircle = "",
  BigUnfilledCircle = "",
  BookMark = "󰃃",
  Calendar = "",
  Check = "󰄳",
  ChevronRight = "",
  Circle = "",
  Close = "󰅖",
  Close_alt = "",
  CloudDownload = "",
  CodeAction = "󰌵",
  Comment = "󰅺",
  Dashboard = "",
  Debugger = "",
  Diagnostic = "󰒡",
  DoubleSeparator = "󰄾",
  Emoji = "󰱫",
  Fire = "",
  Gear = "",
  History = "󰄉",
  Incoming = "󰏷",
  Indicator = "",
  Keyboard = "",
  Left = "",
  List = "",
  Lock = "󰍁",
  Modified = "✥",
  Modified_alt = "",
  Newspaper = "",
  Note = "󰍨",
  Outgoing = "󰏻",
  Package = "",
  Pencil = "󰏫",
  Perf = "󰅒",
  Play = "",
  Project = "",
  Right = "",
  Search = "󰍉",
  Separator = "",
  SignIn = "",
  SignOut = "",
  Sort = "",
  Spell = "󰓆",
  Square = "",
  Tab = "",
  Table = "",
  Telescope = "",
}

---@class AndromedaIcons
Andromeda.icons = {
  ui = ui,
  lsp = lsp,
  cmp = cmp,
  dap = dap,
  git = git,
  kind = kind,
  misc = misc,
  type = type,
  documents = documents,
  diagnostics = diagnostics,
}

require("andromedavim.icons.text")
require("andromedavim.icons.utils")
