require("hop").setup()

require("focus").setup({
  autoresize = {
    enable = false,
    height_quickfix = 2,
  },
})

require("toggleterm").setup({
  open_mapping = [[<c-\>]],
  direction = "float",
  float_opts = {
    border = "curved",
  },
  on_open = function(term)
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "n",
      "q",
      "i",
      { noremap = true, silent = true }
    )
  end,
})

require("winshift").setup({})

require("scrollbar").setup()

require("virt-column").setup({ virtcolumn = "80" })

require("nvim-surround").setup()

require("scope").setup({})

require("oil").setup({
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-s>"] = false,
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-q>"] = "actions.close",
    ["<C-b>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
})

require("spider").setup({
  skipInsignificantPunctuation = true,
  subwordMovement = false,
})
require("catppuccin").setup({
  dim_inactive = {
    enabled = true, -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
})
