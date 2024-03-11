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
    opts = {},
  },
  { "sindrets/winshift.nvim" },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({})
    end,
  },
  { "petertriho/nvim-scrollbar" },
  { "lukas-reineke/virt-column.nvim" },
  { "kylechui/nvim-surround" },
  {
    "NStefan002/visual-surround.nvim",
    config = true, -- use defaults
  },
  { "kevinhwang91/nvim-hlslens" },
  {
    "bloznelis/before.nvim",
    config = function()
      local before = require("before")
      before.setup({
        history_size = 128,
        telescope_for_preview = true,
      })

      -- Jump to previous entry in the edit history
      vim.keymap.set("n", "88", before.jump_to_last_edit, {})

      -- Jump to next entry in the edit history
      vim.keymap.set("n", "99", before.jump_to_next_edit, {})

      -- Move edit history to quickfix (or telescope)
      vim.keymap.set("n", "<leader>oe", before.show_edits, {})
    end,
  },
  { "tiagovla/scope.nvim" },
}
