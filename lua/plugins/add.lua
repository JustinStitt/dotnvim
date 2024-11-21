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
      outline_window = {
        width = 20,
      },
    },
  },
  { "sindrets/winshift.nvim" },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        hide_cursor = false,
      })
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
  { "tpope/vim-fugitive" },
  { "hiphish/rainbow-delimiters.nvim" },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "s1n7ax/nvim-window-picker" },
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup({
        autowidth = {
          enable = false,
        },
        ignore = { -- |windows.ignore|
          buftype = { "quickfix", "nofile" },
          filetype = { "NvimTree", "neo-tree", "undotree", "gundo" },
        },
      })
    end,
  },
  -- {
  --   "chrisgrieser/nvim-early-retirement",
  --   config = true,
  --   event = "VeryLazy",
  --   opts = {
  --     retirementAgeMins = 30,
  --     minimumBufferNum = 9,
  --   },
  -- },
  {
    "gbprod/yanky.nvim",
    opts = {},
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function()
      require("telescope").load_extension("smart_open")
    end,
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
  },
  { "chrisgrieser/nvim-spider" },
  {
    "folke/zen-mode.nvim",
    opts = {},
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "/usr/local/google/home/justinstitt/.config/nvim/get_openai_api_key.sh",
        openai_params = {
          model = "gpt-4-turbo",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 4096, -- hand-modify file in ~/.local/share/nvim as per https://github.com/jackMort/ChatGPT.nvim/issues/444
          temperature = 0,
          top_p = 1,
          n = 1,
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")

      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.

      set({ "n", "v" }, "?", function()
        mc.addCursor()
      end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "v" }, "<leader>n", function()
        mc.matchAddCursor(1)
      end)

      -- Rotate the main cursor.
      set({ "n", "v" }, "<left>", mc.nextCursor)
      set({ "n", "v" }, "<right>", mc.prevCursor)

      -- Delete the main cursor.
      set({ "n", "v" }, "<leader>x", mc.deleteCursor)

      -- Add and remove cursors with control + left click.
      set("n", "<c-leftmouse>", mc.handleMouse)

      set({ "n", "v" }, "<leader>X", function()
        if mc.cursorsEnabled() then
          mc.disableCursors()
        else
          mc.addCursor()
        end
      end)

      set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler.
        end
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { link = "Cursor" })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
  {
    "https://github.com/ggandor/leap.nvim",
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
}
