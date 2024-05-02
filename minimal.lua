-- minimal nvim setup (no plugins, best for random servers)
vim.opt.number = true
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("x", "<Space>", "<ESC>")
vim.keymap.set("n", "<C-s>", "<cmd>:w<cr>")
vim.keymap.set("n", "<C-q>", "<cmd>:q<cr>")
vim.api.nvim_set_option("clipboard", "unnamed")
vim.keymap.set("n", "S", "/")
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
