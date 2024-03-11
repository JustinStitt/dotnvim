require("hlslens").setup({})

require("scrollbar.handlers.search").setup({})

local kopts = { noremap = true, silent = true }

vim.api.nvim_set_keymap(
  "n",
  "n",
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts
)
vim.api.nvim_set_keymap(
  "n",
  "N",
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts
)
vim.api.nvim_set_keymap("n", "*", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "#", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

local should_profile = os.getenv("NVIM_PROFILE")
if should_profile then
  require("profile").instrument_autocmds()
  if should_profile:lower():match("^start") then
    require("profile").start("*")
  else
    require("profile").instrument("*")
  end
end

local function toggle_profile()
  local prof = require("profile")
  if prof.is_recording() then
    prof.stop()
    vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
      if filename then
        prof.export(filename)
        vim.notify(string.format("Wrote %s", filename))
      end
    end)
  else
    prof.start("*")
  end
end

vim.keymap.set("", "]-", toggle_profile)
