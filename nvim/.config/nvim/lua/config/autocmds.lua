-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable virtual text for diagnostics (hides inline error messages)
vim.diagnostic.config({
  virtual_text = false,
  -- You can still see diagnostics with:
  -- - Signs in the gutter (left column)
  -- - <leader>cd to open diagnostics window
  -- - Hover with K over the line
})
