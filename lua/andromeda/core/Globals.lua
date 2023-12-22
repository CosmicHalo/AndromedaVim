Globals = {}

local os_name = vim.loop.os_uname().sysname
local home = Globals.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")

Globals.home = home
Globals.is_mac = os_name == "Darwin"
Globals.is_linux = os_name == "Linux"
Globals.is_wsl = vim.fn.has("wsl") == 1
Globals.vim_path = vim.fn.stdpath("config")
Globals.is_windows = os_name == "Windows_NT"
Globals.path_sep = Globals.is_windows and "\\" or "/"
Globals.modules_dir = Globals.vim_path .. Globals.path_sep .. "modules"
Globals.andromeda = Globals.vim_path .. Globals.path_sep .. "lua/andromeda"
Globals.data_dir = string.format("%s/site/", vim.fn.stdpath("data"))
Globals.cache_dir = home .. Globals.path_sep .. ".cache" .. Globals.path_sep .. "nvim" .. Globals.path_sep

--! >>>>>>>>> Functions <<<<<<<<<<< --

--* Debugging
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

--* File Path
---@param file string
function FileExist(file)
  -- some error codes:
  -- 13 : EACCES - Permission denied
  -- 17 : EEXIST - File exists
  -- 20	: ENOTDIR - Not a directory
  -- 21	: EISDIR - Is a directory
  --
  local isok, errstr, errcode = os.rename(file, file)
  if isok == nil then
    if errcode == 13 then
      -- Permission denied, but it exists
      return true
    end
    return false
  end
  return true
end

---@param path string
function IsDirectory(path) return FileExist(path .. "/") end

---@param path string
function LoadDirectory(path, skip_directories, load_fn)
  skip_directories = skip_directories or false
  load_fn = load_fn or function(p) require("andromeda." .. p) end

  local filepath = Globals.andromeda .. "/" .. path .. "/*"
  local files = vim.split(vim.fn.glob(filepath), "\n")

  table.sort(files, function(a, b)
    local a_name = a:match("^.+/(.+)$"):gsub("%..+$", "")
    local b_name = b:match("^.+/(.+)$"):gsub("%..+$", "")

    if a_name == "init" then
      return true
    elseif b_name == "init" then
      return false
    else
      return a_name < b_name
    end
  end)

  for _, file in ipairs(files) do
    local filename = file:match("^.+/(.+)$"):gsub("%..+$", "")

    if IsDirectory(file) then
      if not skip_directories then LoadDirectory(path .. "/" .. filename, skip_directories, load_fn) end
    else
      load_fn(path:gsub(Globals.path_sep, "."):concat(".", filename))
    end
  end
end
