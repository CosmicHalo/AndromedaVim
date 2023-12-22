Globals = {}

local os_name = vim.loop.os_uname().sysname
local path_sep = Globals.is_windows and "\\" or "/"
local home = Globals.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")

Globals.home = home
Globals.is_mac = os_name == "Darwin"
Globals.is_linux = os_name == "Linux"
Globals.is_wsl = vim.fn.has("wsl") == 1
Globals.vim_path = vim.fn.stdpath("config")
Globals.is_windows = os_name == "Windows_NT"
Globals.modules_dir = Globals.vim_path .. path_sep .. "modules"
Globals.data_dir = string.format("%s/site/", vim.fn.stdpath("data"))
Globals.cache_dir = home .. path_sep .. ".cache" .. path_sep .. "nvim" .. path_sep

Debug = function(...)
  local str = ""
  local args = { ... }

  for i, v in ipairs(args) do
    str = str .. vim.inspect(v)
    if i ~= #args then str = str .. ", " end
  end

  Echo(str, false, true)
end

---@param str string
---@param history? boolean
---@param key_return? boolean
Echo = function(str, history, key_return)
  history = history or false
  key_return = key_return or false

  vim.cmd("redraw")
  vim.api.nvim_echo({ { str, "Bold" } }, history, {})
  if key_return then vim.fn.getchar() end
end
