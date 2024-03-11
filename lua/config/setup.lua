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
})

require("winshift").setup({})

require("kanagawa").setup({
  compile = false,
  undercurl = true, -- enable undercurls
  commentStyle = { italic = false },
  functionStyle = { bold = true },
  keywordStyle = { italic = false },
  statementStyle = { bold = true },
  typeStyle = {},
  variablebuiltinStyle = { italic = false },
  specialReturn = false, -- special highlight for the return keyword
  dimInactive = true,
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  },
})

require("scrollbar").setup()

require("virt-column").setup({ virtcolumn = "80" })

require("nvim-surround").setup()

require("scope").setup({})
