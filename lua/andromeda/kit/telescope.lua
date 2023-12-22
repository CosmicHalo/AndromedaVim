---@type AndromedaTelescopeKit
Andromeda.kit.telescope = {}

---@class AndromedaTelescopeKitOpts
---@field cwd? string|boolean
---@field show_untracked? boolean

---@class AndromedaTelescopeKit
---@overload fun(builtin:string, opts?:AndromedaTelescopeKitOpts)
local M = setmetatable(Andromeda.kit.telescope, {
  __call = function(m, ...) return m.telescope(...) end,
})

---@param extension string
function M.load_extension(extension)
  ---@diagnostic disable-next-line: redundant-parameter
  require("astrocore").on_load("telescope.nvim", function() require("telescope").load_extension(extension) end)
end

----------------
-- Config Files
----------------
function M.config_files() return Andromeda.kit.telescope("find_files", { cwd = vim.fn.stdpath("config") }) end

-- this will return a function that calls telescope.
---@param builtin string
---@param opts? AndromedaTelescopeKitOpts
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }

  return function()
    builtin = params.builtin

    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = Andromeda.kit.root() }, opts or {}) --[[@as AndromedaTelescopeKitOpts]]

    ---------
    -- FILES
    ---------
    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end

    ---------
    -- CWD
    ---------
    if opts.cwd and opts.cwd ~= vim.loop.cwd() then
      ---@diagnostic disable-next-line: inject-field
      opts.attach_mappings = function(_, map)
        map("i", "<a-c>", function()
          local action_state = require("telescope.actions.state")
          local line = action_state.get_current_line()
          M.telescope(
            params.builtin,
            vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
          )()
        end)
        return true
      end
    end

    require("telescope.builtin")[builtin](opts)
  end
end

return M
