local M = setmetatable({}, {
  __index = function(t, k)
    t[k] = require("andromeda.core." .. k)
    return t[k]
  end,
})

M.did_init = false

function M.init()
  if M.did_init then return end

  M.did_init = true

  if vim.g.andromedavim_first_install then
    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyInstall",
      desc = "Load Mason and Treesitter after Lazy installs plugins",
      callback = function()
        vim.cmd.bw()
        vim.api.nvim_exec_autocmds("VimEnter", { modeline = false })
      end,
    })
  end

  -- set options
  if vim.bo.filetype == "lazy" then vim.cmd.bw() end
  require("andromeda.core.options")

  Andromeda.kit.lazy_notify()
  Andromeda.kit.root.setup()
  Andromeda.kit.format.setup()
end

return M
