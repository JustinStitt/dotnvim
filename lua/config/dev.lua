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

vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })

function EnterLinuxMode()
  print("Entering linux mode 😼")
  vim.cmd([[ setlocal noexpandtab ]])
  vim.cmd([[ setlocal shiftwidth=8 ]])
  vim.cmd([[ setlocal tabstop=8 ]])
  vim.api.nvim_buf_set_keymap(0, "n", "<C-s>", "<cmd>:noa w<cr>", {})
  vim.api.nvim_buf_set_keymap(0, "i", "<C-s>", "<Esc><cmd>:noa w<cr>", {})
  vim.cmd([[ set list ]])
end

local function is_in_linux_project()
  local filepath = vim.api.nvim_buf_get_name(0) -- Get current buffer path
  if filepath == "" then
    return false
  end
  local current_dir = vim.fs.dirname(filepath)
  if not current_dir then
    return false
  end
  while true do
    local basename = vim.fs.basename(current_dir)
    if basename == "linux" then
      return true
    end
    local parent_dir = vim.fs.dirname(current_dir)
    if parent_dir == current_dir or parent_dir == nil or parent_dir == "" then
      break
    end
    current_dir = parent_dir
  end
  return false
end

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    if is_in_linux_project() then
      EnterLinuxMode()
    end
  end,
})

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*.c",
--   callback = function()
--     -- local dir = vim.fn.expand('%:h')
--     local dir = vim.fn.getcwd()
--     if string.find(dir, "linux") then
--       EnterLinuxMode()
--     else
--       vim.cmd([[ hi clear TAB ]])
--     end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*.h",
--   callback = function()
--     -- local dir = vim.fn.expand('%:h')
--     local dir = vim.fn.getcwd()
--     if string.find(dir, "linux") then
--       EnterLinuxMode()
--     else
--       vim.cmd([[ hi clear TAB ]])
--     end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd(
--   "BufRead",
--   { pattern = "Makefile", command = "lua EnterLinuxMode()" }
-- )
--
-- vim.api.nvim_create_autocmd(
--   "BufRead",
--   { pattern = "*.eml", command = "lua EnterLinuxMode()" }
-- )
--
-- vim.api.nvim_create_autocmd(
--   "BufRead",
--   { pattern = "COMMIT_EDITMSG", command = "lua EnterLinuxMode()" }
-- )
--
-- vim.api.nvim_create_autocmd(
--   "BufWinLeave",
--   { pattern = "*.*", command = "mkview" }
-- )
--
-- vim.api.nvim_create_autocmd(
--   "BufWinEnter",
--   { pattern = "*.*", command = "silent! loadview" }
-- )

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

-- as per https://github.com/LazyVim/LazyVim/discussions/326 (for performance)
vim.lsp.set_log_level("off")
-- vim.g.matchparen_timeout = 2
-- vim.g.matchparen_insert_timeout = 2
-- vim.opt.syntax = "off"
-- vim.o.foldenable = false
-- vim.o.spell = false

-- local should_profile = os.getenv("NVIM_PROFILE")
-- if should_profile then
--   require("profile").instrument_autocmds()
--   if should_profile:lower():match("^start") then
--     require("profile").start("*")
--   else
--     require("profile").instrument("*")
--   end
-- end
--
-- local function toggle_profile()
--   local prof = require("profile")
--   if prof.is_recording() then
--     prof.stop()
--     vim.ui.input({
--       prompt = "Save profile to:",
--       completion = "file",
--       default = "profile.json",
--     }, function(filename)
--       if filename then
--         prof.export(filename)
--         vim.notify(string.format("Wrote %s", filename))
--       end
--     end)
--   else
--     prof.start("*")
--   end
-- end
-- vim.keymap.set("", ",6", toggle_profile)
