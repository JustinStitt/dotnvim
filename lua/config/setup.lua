require("hop").setup()

require("focus").setup({
  autoresize = {
    enable = false,
    height_quickfix = 2,
  },
})

local terms = require("toggleterm.terminal")
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
    if terms.next_id() == 2 then
      term.display_name = "dev"
    end
  end,
  winbar = { enable = true },
})

require("winshift").setup({})

require("scrollbar").setup({})

require("virt-column").setup({ virtcolumn = "80" })

require("nvim-surround").setup()

require("scope").setup({})

require("tiny-inline-diagnostic").setup({
  preset = "modern",
  show_all_diags_on_cursorline = true,
  options = {
    multiple_diag_under_cursor = true,
    overflow = {
      mode = "wrap",
    },

    multilines = {
      enabled = true,
      always_show = true,
    },
  },
})
