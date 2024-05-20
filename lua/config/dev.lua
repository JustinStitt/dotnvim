vim.api.nvim_command([[
  autocmd ColorScheme * highlight NormalFloat guibg=#1f1f28
]])

vim.api.nvim_command(
  [[ autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f1f28 ]]
)

vim.api.nvim_command([[
  autocmd ColorScheme * highlight SpellBad guifg=red
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
  vim.cmd([[ hi TAB guibg=#23232f ]])
  vim.cmd([[ set noexpandtab ]])
  vim.cmd([[ set shiftwidth=8 ]])
  vim.cmd([[ set tabstop=8 ]])
  -- vim.cmd([[ set nolist ]])
end

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.c",
  callback = function()
    local cwd = vim.fn.getcwd()
    if string.find(cwd, "linux") then
      EnterLinuxMode()
    end
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.h",
  callback = function()
    local cwd = vim.fn.getcwd()
    if string.find(cwd, "linux") then
      EnterLinuxMode()
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
  vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>:noa w<cr>")
  vim.g.autoformat = false
end

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    local cwd = vim.fn.getcwd()
    if string.find(cwd, "llvm") or (string.find(cwd, "linux")) then
      disable_format_on_save()
    end
  end,
})

vim.keymap.set("n", "<leader>lf", function()
  disable_format_on_save()
end, { noremap = true })

vim.api.nvim_command([[
  set listchars=tab:\ \ 
]])
