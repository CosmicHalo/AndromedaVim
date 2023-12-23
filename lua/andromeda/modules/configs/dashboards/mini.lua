local autocmd = vim.api.nvim_create_autocmd

return {
  opts = function()
    local starter = require("mini.starter")

    local pad = string.rep(" ", 18)
    local new_section = function(name, action, section)
      return { name = name, action = action, section = pad .. section }
    end

    local header = function()
      local hour = tonumber(vim.fn.strftime("%H"))
      local part_id = math.floor((hour + 4) / 8) + 1
      local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
      local username = vim.loop.os_get_passwd()["username"] or "USERNAME"
      return ("        Greetings! Good %s, %s"):format(day_part, username)
    end

    return {
      header = header,
      evaluate_single = true,
      content_hooks = {
        starter.gen_hook.aligning("center", "center"),
        starter.gen_hook.adding_bullet(pad .. "» ", false),
      },

      items = {
        new_section("Find file", "Telescope find_files", "Telescope"),
        new_section("Recent files", "Telescope oldfiles", "Telescope"),
        new_section("Grep text", "Telescope live_grep", "Telescope"),
        new_section("Lazyman Menu", "Lazyman", "Config"),
        new_section("Configuration Menu", "Lazyconf", "Config"),
        new_section("Manage Plugins", "Lazy", "Config"),
        new_section("Package Manager", "Mason", "Config"),
        new_section("Help Cheatsheet", "Cheatsheet", "Config"),
        new_section("New file", "ene | startinsert", "Built-in"),
        new_section("Quit", "qa", "Built-in"),
      },
    }
  end,
  config = function(_, config)
    -- close Lazy and re-open when starter is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      autocmd("User", {
        pattern = "MiniStarterOpened",
        callback = function() require("lazy").show() end,
      })
    end

    local starter = require("mini.starter")
    starter.setup(config)

    autocmd("User", {
      pattern = "MiniStarterOpened",
      callback = function()
        local datetime = os.date("  %Y-%b-%d   %H:%M:%S", os.time())
        local version = vim.version()
        local version_info = ""
        if version ~= nil then version_info = "v" .. version.major .. "." .. version.minor .. "." .. version.patch end
        local stats = require("lazy").stats()
        local vinfo = "Neovim " .. version_info
        local lazystats = "  loaded " .. stats.count .. " plugins "
        starter.config.footer = datetime .. "  " .. vinfo .. lazystats
        pcall(starter.refresh)
      end,
    })
  end,
}
