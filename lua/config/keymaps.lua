-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "S", "/<Space><BS>")
-- vim.keymap.set("n", "q]]", "F{a<CR><Esc>$i<CR><up><CR><up><Tab>")
vim.keymap.set({ "n" }, "gr", require("telescope.builtin").lsp_references)
vim.keymap.set({ "n" }, "gd", require("telescope.builtin").lsp_definitions)
vim.keymap.set({ "n" }, "gI", require("telescope.builtin").lsp_implementations)
-- vim.keymap.set({ "n" }, ",r", require("telescope.builtin").resume) -- how handled in core-changes
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
-- vim.keymap.set("n", "P", '"0p', { silent = true })
vim.keymap.set({ "x", "v" }, "J", " :m '>+<cr>gv=gv<left>")
vim.keymap.set({ "x", "v" }, "K", " :m '<-2<CR>gv=gv<left>", { noremap = true })
vim.keymap.set({ "n" }, "zF", "zMzOzz", { noremap = true })
vim.keymap.set({ "n" }, "'", "<cmd>:BufferLinePick<cr>")
vim.keymap.set("v", "Z", function()
  require("lazyvim.util").format.format({ force = true })
end)
vim.keymap.set(
  { "n" },
  "<leader>cf",
  "<cmd>:lua print('lets not format the whole file 😀')<cr>"
)
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
vim.keymap.set(
  { "n" },
  ",mJ",
  "ggOHi,<cr><Esc>Go<cr><C-w><cr>Thanks<cr>Justin<Esc>"
)

-- vim.keymap.set({ "n" }, ",,", "<cmd>:Telescope buffers<cr><Esc>") -- we're doing this in core-changes.lua now
vim.keymap.set({ "n" }, ",mN", "oCc: Nathan Chancellor <nathan@kernel.org>")
vim.keymap.set({ "n" }, ",mh", "oCc: linux-hardening@vger.kernel.org")
vim.keymap.set({ "n" }, ",W", "<cmd>:WinShift<cr>")
vim.keymap.set({ "n" }, "<C-s>", "<cmd>:w<cr>")
vim.keymap.set({ "i" }, "<C-s>", "<Esc><cmd>:w<cr>")
vim.keymap.set({ "n", "i" }, "<C-q>", "<cmd>:q<cr>")
vim.keymap.set("n", "<<", function()
  require("barbecue.ui").navigate(-1)
end)

vim.keymap.set("n", "<leader><Tab>", "<Cmd>:tabn<cr>")
vim.keymap.set("n", "<leader><S-Tab>", "<Cmd>:tabp<cr>")
vim.keymap.set("n", "<Tab>", "<cmd>:BufferLineCycleNext<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>:BufferLineCyclePrev<cr>")
vim.keymap.set("n", "<leader>>>", "<cmd>:BufferLineMoveNext<cr>")
vim.keymap.set("n", "<leader><<", "<cmd>:BufferLineMovePrev<cr>")
vim.keymap.set("n", "<leader>ce", "<cmd>:lua EnterLinuxMode()<cr>")
vim.keymap.set("n", "<leader>\\", "<cmd>:BufferLinePick<cr>")
vim.keymap.set("n", "<leader>z", "<cmd>:ZenMode<cr>")
vim.keymap.set("n", "-", "<cmd>:split<cr>")
vim.keymap.set("n", "|", "<cmd>:vsplit<cr>")
-- vim.keymap.set("n", "<C-b>", "<cmd>:lua MiniFiles.open()<cr>")
vim.keymap.set("n", "<C-j>", "<C-e>")
vim.keymap.set("n", "<C-k>", "<C-y>")
vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("x", "<Space>", "<Esc>")

vim.cmd([[
  nnoremap * #
  nnoremap # *
]])

vim.keymap.set("n", "s", "<cmd>:HopChar1<cr>")
vim.keymap.set("n", "W", "viW")
local function ready_to_surround()
  local ts = require("nvim-treesitter")
  print("test")
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<C-[>", true, false, true),
    "n",
    false
  )
  vim.api.nvim_feedkeys("v", "n", false)
end
vim.keymap.set("n", ",mm", ready_to_surround)
-- vim.keymap.set("n", "<S-l>", "<cmd>:FocusSplitCycle<cr>")
vim.keymap.set("i", "<C-l>", "<right>")
vim.keymap.set("i", "<C-h>", "<left>")
vim.keymap.set("n", "<S-h>", "<cmd>:FocusSplitCycle reverse<cr>")
vim.keymap.set("n", "<C-l>", "<C-w>p")
vim.keymap.set("t", "<C-l>", "<C-l>") -- allows clearing of terminal when in ToggleTerm
vim.keymap.set("t", "<C-k>", "<C-k>")
vim.keymap.set("t", "<C-k>", "<C-k>")
vim.keymap.set("t", "<C-j>", "<C-j>")
vim.keymap.set("t", "jk", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set("n", "(", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", ")", "<Plug>(YankyNextEntry)")

vim.keymap.set("n", "<leader>u", "<Cmd>:UndotreeToggle<cr>:UndotreeFocus<cr>")
-- vim.keymap.set("n", "qS", "<cmd>:noh<cr>")
vim.keymap.set("x", "S", "<Plug>(nvim-surround-visual)")
vim.keymap.set("n", "<leader>le", "<cmd>:Telescope quickfix<cr>")
local cmp = require("cmp")
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
-- vim.keymap.set("n", "_", "<cmd>:Oil<cr>") -- Disabled, using Fyler now

-- vim.keymap.set("n", "<leader>so", function()
--   require("telescope").extensions.smart_open.smart_open()
-- end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>;", "<cmd>:Dashboard<cr>")
vim.keymap.set("n", "T", "`^", { noremap = true, silent = true })
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

  if string.find(bufname, "fyler") then
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

vim.keymap.set("n", "=", "<cmd>:WindowsMaximize<cr>")
vim.keymap.set("n", "<C-n>", "<cmd>:WindowsEqualize<cr>")

-- HARPOON
local harpoon = require("harpoon")
local extensions = require("harpoon.extensions")
harpoon:setup({})
harpoon:extend(extensions.builtins.navigate_with_number())
vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end, { desc = "[a]dd To Harpoon List" })
vim.keymap.set("n", "\\", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
-- END HARPOON
--
vim.keymap.set("n", "<leader>th", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "[T]oggle Inlay [H]ints" })

vim.keymap.set(
  { "n", "o", "x" },
  "w",
  "<cmd>lua require('spider').motion('w', {subwordMovement=true})<CR>",
  { desc = "Spider-w" }
)
vim.keymap.set(
  { "n", "o", "x" },
  "e",
  "<cmd>lua require('spider').motion('e')<CR>",
  { desc = "Spider-e" }
)
vim.keymap.set(
  { "n", "o", "x" },
  "b",
  "<cmd>lua require('spider').motion('b')<CR>",
  { desc = "Spider-b" }
)

local mc = require("multicursor-nvim")
vim.keymap.set("n", "<esc>", function()
  if not mc.cursorsEnabled() then
    mc.enableCursors()
  elseif mc.hasCursors() then
    mc.clearCursors()
  else
    vim.cmd([[ :noh ]])
    -- Default <esc> handler.
  end
end)

vim.keymap.set({ "v" }, "<C-k>", function()
  mc.lineAddCursor(-1)
end)

vim.keymap.set({ "v" }, "<C-j>", function()
  mc.lineAddCursor(1)
end)

vim.keymap.set({ "v" }, "_", function()
  mc.lineSkipCursor(-1)
end)

vim.keymap.set({ "v" }, "+", function()
  mc.lineSkipCursor(1)
end)

vim.keymap.set({ "n", "v" }, "<leader>A", mc.matchAllAddCursors)
vim.keymap.set({ "n", "v" }, "<leader>M", mc.searchAllAddCursors)

local neoscroll = require("neoscroll")
vim.keymap.set({ "n", "v", "x" }, "<C-d>", function()
  neoscroll.ctrl_d({ duration = 100 })
end)
vim.keymap.set({ "n", "v", "x" }, "<C-u>", function()
  neoscroll.ctrl_u({ duration = 100 })
end)

vim.keymap.set({ "n", "t" }, "<leader>.", function()
  local name = vim.fn.input("Terminal name: ")
  if name ~= "" then
    vim.cmd(":TermNew name=" .. name)
  else
    vim.cmd(":TermNew")
  end
end)

vim.keymap.set({ "t" }, "<c-h>", "<cmd>TermSelect<cr>")
vim.keymap.set({ "t" }, "<c-n>", "<cmd>ToggleTermSetName<cr>", {
  noremap = true,
  silent = true,
  desc = "Rename ToggleTerm Terminal",
})

require("cmp").setup({
  mapping = {
    ["<C-]>"] = require("minuet").make_cmp_map(),
    ["<A-y>"] = require("minuet").make_cmp_map(),
  },
})

vim.keymap.set({ "n" }, "<C-f>", Copy_full_path)

local terms = require("toggleterm.terminal")
vim.keymap.set({ "t" }, "<C-g>", function()
  local focused = terms.get_focused_id()
  local all_ids = {}
  local idx = nil
  for i, t in pairs(terms.get_all()) do
    all_ids[i] = t.id
    if t.id == focused then
      idx = i
    end
  end

  local next_idx = idx + 1
  if next_idx > #all_ids then
    next_idx = 1
  end

  if next_idx == idx then
    require("toggleterm").new(nil, nil, nil, "dev2")
  end
  require("toggleterm").toggle(next_idx)
end)
