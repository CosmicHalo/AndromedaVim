local function augroup(name) return vim.api.nvim_create_augroup("andromedavim_" .. name, { clear = true }) end

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  group = augroup "YankHighlight",
  callback = function() vim.highlight.on_yank() end,
})
