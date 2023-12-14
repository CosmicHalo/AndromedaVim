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
  Default = "",
  File = "",
  Files = "",
  FileTree = "󰙅",
  Import = "",
  Symlink = "",
}

---@enum (key) GitIcons
local git = {
  Add = "",
  Branch = "",
  Diff = "",
  Git = "󰊢",
  Ignore = "",
  Mod = "M",
  Mod_alt = "",
  Remove = "",
  Rename = "",
  Repo = "",
  Unmerged = "󰘬",
  Untracked = "󰞋",
  Unstaged = "",
  Staged = "",
  Conflict = "",
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
  LspAvailable = "󱜙",
  ManUp = "",
  Neovim = "",
  NoActiveLsp = "󱚧",
  Power = "⏻",
  PyEnv = "󰢩",
  Rocket = "",
  Squirrel = "",
  Sparkle = "",
  Tag = "",
  Tree = "",
  Vbar = "│",
  Vim = "",
  Watch = "",
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

---@enum (key) UIIcons
local ui = {
  Accepted = "",
  ArrowClosed = "",
  ArrowOpen = "",
  BigCircle = "",
  BigUnfilledCircle = "",
  BookMark = "󰃃",
  Bug = "",
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
  DoubleSeparator = "󰄾",
  Emoji = "󰱫",
  EmptyFolder = "",
  EmptyFolderOpen = "",
  File = "󰈤",
  Fire = "",
  Folder = "",
  FolderOpen = "",
  FolderWithHeart = "󱃪",
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
  NewFile = "",
  Newspaper = "",
  Note = "󰍨",
  Outgoing = "󰏻",
  Package = "",
  Pencil = "󰏫",
  Perf = "󰅒",
  Play = "",
  Project = "",
  Right = "",
  RootFolderOpened = "",
  Search = "󰍉",
  Separator = "",
  SignIn = "",
  SignOut = "",
  Sort = "",
  Spell = "󰓆",
  Square = "",
  Symlink = "",
  SymlinkFolder = "",
  Tab = "",
  Table = "",
  Telescope = "",
}

---@class AndromedaUIIcons
---@field get GetIconFunction<UIIcons>
---@field get_wrapped GetWrapIconFunction<UIIcons>

---@class AndromedaCmpIcons
---@field get GetIconFunction<CmpIcons>
---@field get_wrapped GetWrapIconFunction<CmpIcons>

---@class AndromedaDapIcons
---@field get GetIconFunction<DapIcons>
---@field get_wrapped GetWrapIconFunction<DapIcons>

---@class AndromedaGitIcons
---@field get GetIconFunction<GitIcons>
---@field get_wrapped GetWrapIconFunction<GitIcons>

---@class AndromedaKindIcons
---@field get GetIconFunction<KindIcons>
---@field get_wrapped GetWrapIconFunction<KindIcons>

---@class AndromedaMiscIcons
---@field get GetIconFunction<MiscIcons>
---@field get_wrapped GetWrapIconFunction<MiscIcons>

---@class AndromedaTypeIcons
---@field get GetIconFunction<TypeIcons>
---@field get_wrapped GetWrapIconFunction<TypeIcons>

---@class AndromedaDocumentIcons
---@field get GetIconFunction<DocumentIcons>
---@field get_wrapped GetWrapIconFunction<DocumentIcons>

---@class AndromedaDiagnosticsIcons
---@field get GetIconFunction<DiagnosticsIcons>
---@field get_wrapped GetWrapIconFunction<DiagnosticsIcons>

---@class AndromedaIcons
Andromeda.icons = {
  ui = ui,
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

-- Andromeda.icons.misc.get = generate_get("misc") --[[@as GetIconFunction<MiscIcons>]]
-- Andromeda.icons.misc.get_wrapped = generate_get("misc", true) --[[@as GetIconFunction<MiscIcons>]]
-- Andromeda.icons.cmp.get = generate_get("cmp") --[[@as GetIconFunction<CmpIcons>]]
-- Andromeda.icons.dap.get = generate_get("dap") --[[@as GetIconFunction<DapIcons>]]
-- Andromeda.icons.git.get = generate_get("git") --[[@as GetIconFunction<GitIcons>]]
-- Andromeda.icons.kind.get = generate_get("kind") --[[@as GetIconFunction<KindIcons>]]
-- Andromeda.icons.type.get = generate_get("type") --[[@as GetIconFunction<TypeIcons>]]
-- Andromeda.icons.documents.get = generate_get("documents") --[[@as GetIconFunction<DocumentIcons>]]
-- Andromeda.icons.diagnostics.get = generate_get("diagnostics") --[[@as GetIconFunction<DiagnosticsIcons>]]
