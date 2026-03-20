-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.statuscolumn = ""
vim.opt.signcolumn = "yes"

vim.g.mkdp_port = "56777"
vim.g.mkdp_echo_preview_url = 1

vim.cmd([[ set background=dark ]])
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.snacks_animate = false -- because i want to use neoscroll

-- clipboard over ssh with byobu/tmux
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

vim.opt.clipboard = "unnamedplus"

-- LSP Server to use for Python (from https://www.lazyvim.org/extras/lang/python)
-- vim.g.lazyvim_python_lsp = "basedpyright"
