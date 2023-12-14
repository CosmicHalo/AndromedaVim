-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file: https://mathew-kurian.github.io/CharacterMap/
-- find more here: https://www.nerdfonts.com/cheat-sheet

---@enum (key) AndromedaCmpIcons
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

---@enum (key) AndromedaDapIcons
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

---@enum (key) AndromedaDiagnosticsIcons
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

---@enum (key) AndromedaDocumentsIcons
local documents = {
  Default = "",
  File = "",
  Files = "",
  FileTree = "󰙅",
  Import = "",
  Symlink = "",
}

---@enum (key) AndromedaGitIcons
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

---@enum (key) AndromedaKindIcons
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

---@enum (key) AndromedaMiscIcons
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

---@enum (key) AndromedaTypeIcons
local type = {
  Array = "󰅪",
  Boolean = "",
  Null = "󰟢",
  Number = "",
  Object = "󰅩",
  String = "󰉿",
}

---@class AndromedaUIIcons
---@enum (key) AndromedaUIIcons
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

---@generic T : table<string, string>
---@alias GetIconFunction<T> fun(kind: T, padding?: integer, wrap?: boolean): string

---@generic T : table<string, string>
---@param pack string
---@return GetIconFunction<T>
local function generate_get(pack)
  return function(iconType, padding, wrap) return Andromeda.icons.get(pack .. "." .. iconType, padding, wrap) end
end

---@generic T : table<string, string>
---@param pack string
---@param wrap? boolean
---@return GetIconFunction<T>
local function generate_wrapped(pack, wrap)
  return function(iconType, padding) return Andromeda.icons.get(pack .. "." .. iconType, padding, wrap) end
end

--- Get an icon from the internal icons if it is available and return it
---@param categoryOrKind Icons The category of icon to retrieve or the icon itself
---@param padding? integer Padding to add to the end of the icon, defaults to 1
---@param wrap? boolean Whether or not to wrap both sides of the icon with spaces
---@return string icon
function Andromeda.icons.get(categoryOrKind, padding, wrap)
  ---@cast categoryOrKind string

  local icons_enabled = vim.g.icons_enabled ~= false
  local icon_pack = assert(Andromeda[icons_enabled and "icons" or "text_icons"])

  local icon = icon_pack
  for _, path in ipairs(string.split(categoryOrKind, ".")) do
    icon = icon[path]
  end

  if not icon then return "" end

  -- Wrap the icon in spaces if requested
  local spacing = string.rep(" ", padding or 1)
  if wrap then return spacing .. icon .. spacing end
  return icon .. spacing
end

--! UI
---@type GetIconFunction<AndromedaUIIcons>
Andromeda.icons.ui.get = generate_get("ui")
---@type GetIconFunction<AndromedaMiscIcons>
Andromeda.icons.ui.get_wrapped = generate_wrapped("ui", true)

--! MISC
---@type GetIconFunction<AndromedaMiscIcons>
Andromeda.icons.misc.get = generate_get("misc")
---@type GetIconFunction<AndromedaMiscIcons>
Andromeda.icons.misc.get_wrapped = generate_wrapped("ui", true)

--! CMP
---@type GetIconFunction<AndromedaCmpIcons>
Andromeda.icons.cmp.get = generate_get("cmp")

--! DAP
---@type GetIconFunction<AndromedaDapIcons>
Andromeda.icons.dap.get = generate_get("dap")

--! GIT
---@type GetIconFunction<AndromedaGitIcons>
Andromeda.icons.git.get = generate_get("git")

--! KIND
---@type GetIconFunction<AndromedaKindIcons>
Andromeda.icons.kind.get = generate_get("kind")

--! TYPE
---@type GetIconFunction<AndromedaTypeIcons>
Andromeda.icons.type.get = generate_get("type")

--! DOCUMENTS
---@type GetIconFunction<AndromedaDocumentsIcons>
Andromeda.icons.documents.get = generate_get("documents")

--! DIAGNOSTICS
---@type GetIconFunction<AndromedaDiagnosticsIcons>
Andromeda.icons.diagnostics.get = generate_get("diagnostics")
