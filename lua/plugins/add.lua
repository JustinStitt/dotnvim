return {
  { "smoka7/hop.nvim" },
  { "nvim-focus/focus.nvim" },
  { "akinsho/toggleterm.nvim" },
  { "mbbill/undotree" },
  {
    "willothy/flatten.nvim",
    opts = {
      window = {
        open = "alternate",
      },
    },
    lazy = false,
    priority = 1001,
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<C-h>", "<cmd>:Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
    },
  },
}
