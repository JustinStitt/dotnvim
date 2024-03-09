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
