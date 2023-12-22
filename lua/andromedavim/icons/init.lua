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
  Dots = "󰇘",
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
  Comment = "󰅺",
  Dashboard = "",
  Debugger = "",
  Diagnostic = "󰒡",
  Fire = "",
  Gear = "",
  Keyboard = "",
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
local icons = {
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

-- >>>>>>>>>>>>>>>>>>>>>>>>> Get Icon <<<<<<<<<<<<<<<<<<<<<<<<< --

---@alias GetWrapIconFunction<T> fun(kind: T, padding?: integer): string
---@alias GetIconFunction<T> fun(kind: T, padding?: integer, wrap?: boolean): string

---@param pack string
---@param is_wrap? boolean
local function generate_get(pack, is_wrap)
  is_wrap = is_wrap or false

  if is_wrap then
    return function(iconType, padding)
      return require("andromedavim.kit.icon").get_icon(pack .. "." .. iconType, padding, true)
    end
  end
  return function(iconType, padding, wrap)
    return require("andromedavim.kit.icon").get_icon(pack .. "." .. iconType, padding, wrap)
  end
end

--! GET
icons.ui.get = generate_get("ui") --[[@as GetIconFunction<UIIcons>]]
icons.lsp.get = generate_get("lsp") --[[@as GetIconFunction<LSPIcons>]]
icons.cmp.get = generate_get("cmp") --[[@as GetIconFunction<CmpIcons>]]
icons.dap.get = generate_get("dap") --[[@as GetIconFunction<DapIcons>]]
icons.git.get = generate_get("git") --[[@as GetIconFunction<GitIcons>]]
icons.kind.get = generate_get("kind") --[[@as GetIconFunction<KindIcons>]]
icons.misc.get = generate_get("misc") --[[@as GetIconFunction<MiscIcons>]]
icons.type.get = generate_get("type") --[[@as GetIconFunction<TypeIcons>]]
icons.documents.get = generate_get("documents") --[[@as GetIconFunction<DocumentIcons>]]
icons.diagnostics.get = generate_get("diagnostics") --[[@as GetIconFunction<DiagnosticsIcons>]]

--! GET WRAPPED
icons.ui.get_wrapped = generate_get("ui", true) --[[@as GetWrapIconFunction<UIIcons>]]
icons.misc.get_wrapped = generate_get("misc", true) --[[@as GetWrapIconFunction<MiscIcons>]]

return icons
