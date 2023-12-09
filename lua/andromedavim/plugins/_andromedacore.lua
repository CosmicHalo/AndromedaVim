require("andromedavim.core").init()

return {
  {
    "AndromedaVim/andromedacore",
    dependencies = { "AndromedaVim/andromedaui", dev = true },
    lazy = false,
    priority = 10000,
    ---@type AndromedaCoreOpts
    opts = {
      features = {
        cmp = true, -- enable completion at start
        autopairs = true, -- enable autopairs at start
        highlighturl = true, -- highlight URLs by default
        notifications = true, -- disable notifications
        max_file = { size = 1024 * 100, lines = 10000 }, -- set global limits for large files
      },
      sessions = {
        autosave = { last = true, cwd = true },
        ignore = {
          dirs = {},
          buftypes = {},
          filetypes = { "gitcommit", "gitrebase" },
        },
      },
    },
  },
}
