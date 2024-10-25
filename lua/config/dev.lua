vim.api.nvim_command([[
  autocmd ColorScheme * highlight NormalFloat guibg=#1f1f28
]])

vim.api.nvim_command(
  [[ autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f1f28 ]]
)

vim.api.nvim_command([[
  hi SpellBad gui=undercurl guisp=#ffff00
  autocmd FileType gitcommit setlocal spell
  " set listchars=tab:>\ ,trail:-,nbsp:+,eol:$
]])

vim.api.nvim_command([[
  highlight FlashCursor guibg=red
]])

vim.cmd([[
  match Space /\s/
]])

vim.cmd([[
  function! HiTabs()
  syntax match TAB /\t/
  hi TAB ctermbg=blue ctermfg=red
  endfunction
  au BufEnter,BufRead * call HiTabs()
]])

function EnterLinuxMode()
  -- vim.cmd([[ hi TAB guibg=#6aa6ba ]])
  vim.cmd([[ setlocal noexpandtab ]])
  vim.cmd([[ setlocal shiftwidth=8 ]])
  vim.cmd([[ setlocal tabstop=8 ]])
  vim.api.nvim_buf_set_keymap(0, "n", "<C-s>", "<cmd>:noa w<cr>", {})
  vim.api.nvim_buf_set_keymap(0, "i", "<C-s>", "<Esc><cmd>:noa w<cr>", {})
  vim.api.nvim_buf_set_keymap(0, "n", "<leader>cf", "<Esc>", {})
  vim.cmd([[
    set listchars=trail:•,tab:⤑⤑
  ]])
  vim.cmd([[ set list ]])
end

vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.c",
  callback = function()
    -- local dir = vim.fn.expand('%:h')
    local dir = vim.fn.getcwd()
    if string.find(dir, "linux") then
      EnterLinuxMode()
    else
      vim.cmd([[ hi clear TAB ]])
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.h",
  callback = function()
    -- local dir = vim.fn.expand('%:h')
    local dir = vim.fn.getcwd()
    if string.find(dir, "linux") then
      EnterLinuxMode()
    else
      vim.cmd([[ hi clear TAB ]])
    end
  end,
})

vim.api.nvim_create_autocmd(
  "BufRead",
  { pattern = "Makefile", command = "lua EnterLinuxMode()" }
)

vim.api.nvim_create_autocmd(
  "BufRead",
  { pattern = "*.eml", command = "lua EnterLinuxMode()" }
)

vim.api.nvim_create_autocmd(
  "BufRead",
  { pattern = "COMMIT_EDITMSG", command = "lua EnterLinuxMode()" }
)

vim.api.nvim_create_autocmd(
  "BufWinLeave",
  { pattern = "*.*", command = "mkview" }
)

vim.api.nvim_create_autocmd(
  "BufWinEnter",
  { pattern = "*.*", command = "silent! loadview" }
)

function disable_format_on_save()
  if vim.g.autoformat == true then
    -- vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>:noa w<cr>")
    vim.g.autoformat = false
  end
end

function enable_format_on_save()
  if vim.g.autoformat == false then
    -- vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>:w<cr>")
    vim.g.autoformat = true
  end
end

vim.api.nvim_create_autocmd("BufWrite", {
  pattern = "*",
  callback = function()
    vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
    local cwd = vim.fn.getcwd()
    if string.find(cwd, "llvm") or (string.find(cwd, "linux")) then
      disable_format_on_save()
    else
      enable_format_on_save()
    end
  end,
})

vim.keymap.set("n", "<leader>lf", function()
  disable_format_on_save()
end, { noremap = true })

vim.api.nvim_command([[
  set listchars=tab:\ \ 
]])

vim.api.nvim_create_user_command("Lightmode", function()
  vim.cmd([[ colorscheme catppuccin-latte ]])
  vim.cmd([[ set background=light ]])
end, {})

vim.api.nvim_create_user_command("Darkmode", function()
  vim.cmd([[ colorscheme kanagawa-wave ]])
  vim.cmd([[ set background=dark ]])
end, {})
