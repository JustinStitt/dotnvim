-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.cmd([[
  set listchars=trail:•,tab:⤑⤑
]])

vim.cmd([[
  autocmd InsertEnter * set listchars=trail:•,tab:⤑⤑
]])

vim.cmd([[
  autocmd InsertLeave * set listchars=trail:•,tab:⤑⤑
]])
--
-- vim.api.nvim_create_autocmd('ModeChanged', {
--   pattern = '*',
--   callback = function()
--     if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
--         and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
--         and not require('luasnip').session.jump_active
--     then
--       require('luasnip').unlink_current()
--     end
--   end
-- })
