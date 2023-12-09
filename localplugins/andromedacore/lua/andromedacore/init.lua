local M = {}

--- A placeholder variable used to queue section names to be registered by which-key
---@type table?
M.which_key_queue = nil

--- The configuration as set by the user through the `setup()` function
M.config = require "andromedacore.config"

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- General Helpers
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end

--- Serve a notification with a title of AndromedaVim
---@param msg string The notification body
---@param type number|nil The type of the notification (:help vim.log.levels)
---@param opts? table The nvim-notify options to use (:help notify-options)
function M.notify(msg, type, opts)
  vim.schedule(function() vim.notify(msg, type, M.extend_tbl({ title = "AndromedaVim" }, opts)) end)
end

--- Trigger an AndromedaVim user event
---@param event string The event name to be appended to Andromeda
function M.event(event)
  vim.schedule(function() vim.api.nvim_exec_autocmds("User", { pattern = "Andromeda" .. event, modeline = false }) end)
end

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- Plugin Loading
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
function M.is_available(plugin) return M.get_plugin(plugin) ~= nil end

--- Get a plugin spec from lazy
---@param plugin string The plugin to search for
---@return LazyPlugin? available # The found plugin spec from Lazy
function M.get_plugin(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return lazy_config_avail and lazy_config.spec.plugins[plugin] or nil
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  local Config = require "lazy.core.config"
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

--- Sync Lazy and then update Mason
function M.update_packages()
  require("lazy").sync { wait = true }
  require("andromedacore.mason").update_all()
end

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- URL/URI Matching
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

--- regex used for matching a valid URL/URI string
M.url_matcher =
  "\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+"

--- Delete the syntax matching rules for URLs/URIs if set
function M.delete_url_match()
  ---@diagnostic disable-next-line: param-type-mismatch
  for _, match in ipairs(vim.fn.getmatches()) do
    if match.group == "HighlightURL" then vim.fn.matchdelete(match.id) end
  end
end

--- Add syntax matching rules for highlighting URLs/URIs
function M.set_url_match()
  M.delete_url_match()
  if require("andromedacore").config.features.highlighturl then vim.fn.matchadd("HighlightURL", M.url_matcher, 15) end
end

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- Keymaps
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

--- Register queued which-key mappings
function M.which_key_register()
  if M.which_key_queue then
    local wk_avail, wk = pcall(require, "which-key")
    if wk_avail then
      for mode, registration in pairs(M.which_key_queue) do
        wk.register(registration, { mode = mode })
      end
      M.which_key_queue = nil
    end
  end
end

--- Get an empty table of mappings with a key for each map mode
---@return table<string,table> # a table with entries for each map mode
function M.empty_map_table()
  local maps = {}
  for _, mode in ipairs { "", "n", "v", "x", "s", "o", "!", "i", "l", "c", "t" } do
    maps[mode] = {}
  end
  if vim.fn.has "nvim-0.10.0" == 1 then
    for _, abbr_mode in ipairs { "ia", "ca", "!a" } do
      maps[abbr_mode] = {}
    end
  end
  return maps
end

--- Table based API for setting keybindings
---@param map_table table A nested table where the first key is the vim mode, the second key is the key to map, and the value is the function to set the mapping to
---@param base? table A base set of options to set on every keybinding
function M.set_mappings(map_table, base)
  local was_no_which_key_queue = not M.which_key_queue

  -- iterate over the first keys for each mode
  base = base or {}

  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd = options
        local keymap_opts = base

        if type(options) == "table" then
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend("force", keymap_opts, options)
          keymap_opts[1] = nil
        end

        if not cmd or keymap_opts.name then -- if which-key mapping, queue it
          if not keymap_opts.name then keymap_opts.name = keymap_opts.desc end
          if not M.which_key_queue then M.which_key_queue = {} end
          if not M.which_key_queue[mode] then M.which_key_queue[mode] = {} end
          M.which_key_queue[mode][keymap] = keymap_opts
        else -- if not which-key mapping, set it
          vim.keymap.set(mode, keymap, cmd, keymap_opts)
        end
      end
    end
  end

  if was_no_which_key_queue and M.which_key_queue then M.on_load("which-key.nvim", M.which_key_register) end
end

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- Setup
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

--- Setup and configure AndromedaCore
---@param opts AndromedaCoreOpts
---@see andromedacore.config
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts)

  -- mappings
  M.set_mappings(M.config.mappings)

  -- autocmds
  for augroup, autocmds in pairs(M.config.autocmds) do
    if autocmds then
      local augroup_id = vim.api.nvim_create_augroup(augroup, { clear = true })
      for _, autocmd in ipairs(autocmds) do
        local event = autocmd.event
        autocmd.event = nil
        autocmd.group = augroup_id
        vim.api.nvim_create_autocmd(event, autocmd)
        autocmd.event = event
      end
    end
  end

  -- user commands
  for cmd, spec in pairs(M.config.commands) do
    if spec then
      local action = spec[1]
      spec[1] = nil
      vim.api.nvim_create_user_command(cmd, action, spec)
      spec[1] = action
    end
  end

  -- on_key hooks
  for namespace, funcs in pairs(M.config.on_keys) do
    if funcs then
      local ns = vim.api.nvim_create_namespace(namespace)
      for _, func in ipairs(funcs) do
        vim.on_key(func, ns)
      end
    end
  end
end

return M
