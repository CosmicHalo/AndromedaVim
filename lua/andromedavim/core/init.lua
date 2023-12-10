local M = {}

M.did_init = false

M.default_dashboard = "doom"
M.default_colorscheme = "solarized-osaka"

M.linters = {}
M.formatters = {}

function M.init()
  if not M.did_init then
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
    require "andromedavim.core.options"
  end

  require("andromedavim.libs").root.setup()
  require("andromedavim.libs").format.setup()
end

return M
