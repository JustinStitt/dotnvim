-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

-- Show mark letter in place of line number when a mark exists on that line.
local function norm(p)
  if not p or p == "" then
    return ""
  end
  return vim.fn.fnamemodify(p, ":p")
end

function _G.MarkStatusColumn()
  local lnum = vim.v.lnum
  local buf = vim.api.nvim_get_current_buf()
  for _, m in ipairs(vim.fn.getmarklist(buf)) do
    local name = m.mark:sub(2, 2)
    if m.pos[2] == lnum and name:match("[a-z]") then
      return "%#MarkSignHL#" .. name .. "%*"
    end
  end
  local file = norm(vim.api.nvim_buf_get_name(buf))
  for _, m in ipairs(vim.fn.getmarklist()) do
    local name = m.mark:sub(2, 2)
    if name:match("[A-Z0-9]") and m.pos[2] == lnum and norm(m.file) == file then
      return "%#MarkSignHL#" .. name .. "%*"
    end
  end
  return tostring(lnum)
end

vim.api.nvim_set_hl(0, "MarkSignHL", { fg = "#e67e80", bold = true })
vim.opt.statuscolumn = "%s%=%{%v:lua.MarkStatusColumn()%} "

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
