for _, module in ipairs { "bootstrap", "options", "lazy" } do
  local status_ok, fault = pcall(require, "andromedavim.core." .. module)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. module .. "\n\n" .. fault) end
end
