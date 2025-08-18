-- minimal nvim setup (no plugins, best for random servers)
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
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
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("x", "<Space>", "<ESC>")
vim.keymap.set("n", "<C-s>", "<cmd>:w<cr>")
vim.keymap.set("n", "<Esc>", "<cmd>:noh<cr>")
vim.keymap.set("i", "<C-s>", "<cmd>:w<cr><Esc>")
vim.keymap.set("n", "<C-q>", "<cmd>:q<cr>")
vim.keymap.set({ "x", "v" }, "J", " :m '>+<cr>gv=gv<left>")
vim.keymap.set({ "x", "v" }, "K", " :m '<-2<CR>gv=gv<left>", { noremap = true })
vim.keymap.set("n", "S", "/")
