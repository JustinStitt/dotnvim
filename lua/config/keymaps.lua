-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "S", "/<Space><BS>")
vim.keymap.set("n", "q]]", "F{a<CR><Esc>$i<CR><up><CR><up><Tab>")
vim.keymap.set({ "n" }, "gr", require("telescope.builtin").lsp_references)
vim.keymap.set({ "n" }, "gd", require("telescope.builtin").lsp_definitions)
vim.keymap.set({ "n" }, "gI", require("telescope.builtin").lsp_implementations)
vim.keymap.set({ "n" }, ",r", require("telescope.builtin").resume)
vim.keymap.set({ "n" }, "<C-p>", "<C-i>", { noremap = true })
vim.keymap.set({ "i" }, "<M-c>", "/**/<left><left>  <left>", { remap = true })
-- vim.keymap.set("n", "J", "$<left> :m .+1<CR>==", { silent = true })
-- vim.keymap.set(
--   "n",
--   "K",
--   "$<left> :m .-2<CR>==",
--   { silent = true, noremap = true }
-- ) -- this is broken with LazyVim, just use visual mode I guess

vim.keymap.set({ "x", "v" }, "<BS>", "<left>", { noremap = true })
vim.keymap.set("n", "P", '"0p', { silent = true })
vim.keymap.set({ "x", "v" }, "J", " :m '>+<cr>gv=gv<left>")
vim.keymap.set({ "x", "v" }, "K", " :m '<-2<CR>gv=gv<left>", { noremap = true })
vim.keymap.set({ "n" }, "zF", "zMzOzz", { noremap = true })
vim.keymap.set("v", "/", "<esc>/\\%V") -- search within selection
vim.keymap.set({ "n" }, ",mk", "oCc: Kees Cook <keescook@chromium.org>")
vim.keymap.set(
  { "n" },
  ",mn",
  "oCc: Nick Desaulniers <ndesaulniers@google.com>"
)
vim.keymap.set(
  { "n" },
  ",mj",
  "oReviewed-by: Justin Stitt <justinstitt@google.com>"
)
vim.keymap.set({ "n" }, ",mJ", "ggOHi,<cr><Esc>Go<cr>Thanks<cr>Justin<Esc>")
vim.keymap.set({ "n" }, ",mN", "oCc: Nathan Chancellor <nathan@kernel.org>")
vim.keymap.set({ "n" }, ",mh", "oCc: linux-hardening@vger.kernel.org")
vim.keymap.set({ "n" }, ",W", "<cmd>:WinShift<cr>")
vim.keymap.set({ "n" }, "<C-s>", "<cmd>:w<cr>")
vim.keymap.set({ "i" }, "<C-s>", "<Esc><cmd>:w<cr>")
vim.keymap.set({ "n", "i" }, "<C-q>", "<cmd>:q<cr>")
vim.keymap.set("n", "<leader><Tab>", "<Cmd>:tabn<cr>")
vim.keymap.set("n", "<leader><S-Tab>", "<Cmd>:tabp<cr>")
vim.keymap.set("n", "<Tab>", "<cmd>:BufferLineCycleNext<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>:BufferLineCyclePrev<cr>")
vim.keymap.set("n", "q>>", "<cmd>:BufferLineMoveNext<cr>")
vim.keymap.set("n", "q<<", "<cmd>:BufferLineMovePrev<cr>")
vim.keymap.set("n", "\\", "<cmd>:BufferLinePick<cr>")
vim.keymap.set("n", "-", "<cmd>:split<cr>")
vim.keymap.set("n", "|", "<cmd>:vsplit<cr>")
-- vim.keymap.set("n", "<C-b>", "<cmd>:lua MiniFiles.open()<cr>")
vim.keymap.set("n", "<C-j>", "<C-e>")
vim.keymap.set("n", "<C-k>", "<C-y>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "<C-h>", "<left>")

vim.keymap.set("x", "<Space>", "<Esc>")
vim.keymap.set("n", ",c", "<cmd>:bd<cr>")

vim.cmd([[
  nnoremap * #
  nnoremap # *
]])

vim.keymap.set("n", "s", "<cmd>:HopChar1<cr>")
vim.keymap.set("n", "qs", "<cmd>:HopChar1MW<cr>")
-- vim.keymap.set("n", "<S-l>", "<cmd>:FocusSplitCycle<cr>")
vim.keymap.set("i", "<C-l>", "<right>")
vim.keymap.set("i", "<C-h>", "<left>")
vim.keymap.set("n", "<S-h>", "<cmd>:FocusSplitCycle reverse<cr>")
vim.keymap.set("n", "<C-l>", "<C-w>p")
vim.keymap.set("t", "<C-l>", "<C-l>") -- allows clearing of terminal when in ToggleTerm
vim.keymap.set("t", "<C-k>", "<C-k>")
vim.keymap.set("t", "<C-j>", "<C-j>")
vim.keymap.set("t", "jk", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

vim.keymap.set("n", "<leader>u", "<Cmd>:UndotreeToggle<cr>:UndotreeFocus<cr>")
vim.keymap.set("n", "qS", "<cmd>:noh<cr>")
vim.keymap.set("x", "S", "<Plug>(nvim-surround-visual)")
vim.keymap.set("n", "<leader>le", "<cmd>:Telescope quickfix<cr>")
local cmp = require("cmp")
vim.keymap.set("i", "<C-Space>", cmp.mapping.close())
vim.keymap.set(
  "n",
  "<C-Space>",
  vim.diagnostic.open_float,
  { noremap = true, silent = true }
)

vim.keymap.set("n", "<leader>gs", "<cmd>:Gitsigns stage_hunk<CR>")
vim.keymap.set("n", "<leader>gr", "<cmd>:Gitsigns reset_hunk<CR>")
vim.keymap.set("n", "<leader>gj", "<cmd>:Gitsigns next_hunk<CR>")
vim.keymap.set("n", "<leader>gk", "<cmd>:Gitsigns prev_hunk<CR>")
vim.keymap.set("n", "<leader>gB", "<cmd>:Git blame<cr>")
vim.keymap.set("n", "<leader>gb", "<cmd>:Git blame<cr>")
vim.keymap.set("n", "<leader>gd", "<cmd>:Gitsigns preview_hunk_inline<cr>")
vim.keymap.set("n", "<leader>sB", "<cmd>:Telescope buffers<cr>")
vim.keymap.set("n", "<leader>so", "<cmd>:Telescope oldfiles<cr>")
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>;", "<cmd>:Dashboard<cr>")
vim.keymap.set("n", "Q", function()
  require("mini.ai").select_textobject("i", "q", {})
end)
vim.keymap.set("x", "Q", function()
  vim.api.nvim_command([[norm! h]])
  require("mini.ai").select_textobject("a", "q", {})
end)
vim.keymap.set("n", "B", function()
  require("mini.ai").select_textobject("i", "b", {})
end)
vim.keymap.set("x", "B", function()
  vim.api.nvim_command([[norm! h]])
  require("mini.ai").select_textobject("a", "b", {})
end)

local function smart_exclude_window_navigation(direction)
  vim.cmd("wincmd " .. direction)
  local bufname = vim.api.nvim_buf_get_name(0)

  if string.find(bufname, "neo%-tree") then
    if direction == "w" then
      smart_exclude_window_navigation(direction)
    else
      vim.cmd("wincmd p")
    end
  end
end

vim.keymap.set("n", "<S-l>", function()
  smart_exclude_window_navigation("w")
end)

-- when pressing <C-b>, instead of closing neotree simply go back to previous window
local function smart_leave_neotree()
  local bufname = vim.api.nvim_buf_get_name(0)
  if string.find(bufname, "neo%-tree") then
    vim.cmd("wincmd p") -- previous window
  else
    vim.cmd("Neotree reveal_force_cwd filesystem left")
  end
end
vim.keymap.set("n", "<C-b>", function()
  smart_leave_neotree()
end)
vim.keymap.set("n", "<C-m>", "<cmd>:WindowsMaximize<cr>")
vim.keymap.set("n", "<C-n>", "<cmd>:WindowsEqualize<cr>")
