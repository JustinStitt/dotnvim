-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.cmd([[
  set listchars=trail:•
]])

vim.cmd([[
  autocmd InsertEnter * set listchars-=trail:•
]])

vim.cmd([[
  autocmd InsertLeave * set listchars+=trail:•
]])
