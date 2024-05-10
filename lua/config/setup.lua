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

require("oil").setup({
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

require("hbac").setup({
  autoclose = true, -- set autoclose to false if you want to close manually
  threshold = 6, -- hbac will start closing unedited buffers once that number is reached
  close_command = function(bufnr)
    vim.api.nvim_buf_delete(bufnr, {})
  end,
  close_buffers_with_windows = false, -- hbac will close buffers with associated windows if this option is `true`
})

require("term-edit").setup({
  prompt_end = "%$ ",
})
