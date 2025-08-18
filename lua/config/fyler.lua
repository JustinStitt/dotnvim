-- Fyler configuration and keymaps
-- NOTE: We need this patch to work well with ToggleTerm:
-- https://github.com/A7Lavinraj/fyler.nvim/pull/115

-- Setup Fyler with configuration
require("fyler").setup({
  views = {
    explorer = {
      close_on_select = false,
      confirm_simple = true,
      default_explorer = true,
      win = {
        kind = "split_left_most",
        kind_presets = {
          split_left_most = {
            width = "45abs",
          },
        },
        win_opts = {
          winfixwidth = true,
          winhighlight = "Normal:Normal,NormalNC:NormalFloat",
        },
      },
    },
  },
})

-- Set up Fyler toggle keymap
vim.keymap.set("n", "<C-b>", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_bufname = vim.api.nvim_buf_get_name(current_buf)
  local current_filetype = vim.bo[current_buf].filetype
  local current_buftype = vim.bo[current_buf].buftype

  -- Check if currently in Fyler window
  if
    current_bufname:match("fyler")
    or current_filetype == "fyler"
    or current_buftype == "acwrite"
  then
    -- We're in Fyler, go back to previous window
    vim.cmd("wincmd p")
    return
  end

  -- Check if Fyler is already open by looking for Fyler buffer names
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local bufname = vim.api.nvim_buf_get_name(buf)
      local filetype = vim.bo[buf].filetype
      local buftype = vim.bo[buf].buftype

      -- Check for Fyler by buffer name pattern or buffer type
      if
        bufname:match("fyler")
        or filetype == "fyler"
        or buftype == "acwrite"
      then
        local wins = vim.fn.win_findbuf(buf)
        if #wins > 0 and vim.api.nvim_win_is_valid(wins[1]) then
          -- Fyler window exists, focus it
          vim.api.nvim_set_current_win(wins[1])
          return
        end
      end
    end
  end

  -- Fyler not open, open it
  local fyler = require("fyler")
  fyler.open({ kind = "split_left_most" })
end)
