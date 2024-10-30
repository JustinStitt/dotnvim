-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.statuscolumn = ""
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard

vim.g.mkdp_port = "56777"
vim.g.mkdp_echo_preview_url = 1

vim.cmd([[ set background=dark ]])
vim.g.lazyvim_python_lsp = "basedpyright"

-- LSP Server to use for Python (from https://www.lazyvim.org/extras/lang/python)
-- vim.g.lazyvim_python_lsp = "basedpyright"
