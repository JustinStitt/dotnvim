-- My personal changes to the LazyVim Core plugins
local actions = require("telescope.actions")
local cmp = require("cmp")
local Util = require("lazyvim.util")

return {
  { -- Support <C-j> and <C-k> for Telescope scrolling
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
    },
    keys = {
      {
        "<leader>st",
        Util.telescope("live_grep", { cwd = false }),
        desc = "Grep (root dir)",
      },
      {
        "<leader>sf",
        Util.telescope("files", { cwd = false }),
        desc = "Find Files (cwd)",
      },
    },
  },
  { -- I want <C-j> and <C-k> to scroll the cmp menu
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({
          behavior = cmp.SelectBehavior.Insert,
        }),
        ["<C-k>"] = cmp.mapping.select_prev_item({
          behavior = cmp.SelectBehavior.Insert,
        }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-S-k>"] = cmp.mapping.complete(),
        ["<C-Space>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }),
    },
  },
  { -- I don't use this feature and it hijacks visual mode <BS>
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        enable = false,
      },
    },
  },
  -- add my favorite colorscheme
  {
    "rebelot/kanagawa.nvim",
    opts = {
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
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = {
          enabled = false, -- just annoying, mostly.
        },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    keys = {
      { "<leader>sT", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>st", false },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      hijack_netrw_behavior = "disabled",
      close_if_last_window = true,
    },
    dependencies = {
      {
        's1n7ax/nvim-window-picker',
        version = '*',
        config = function()
          require 'window-picker'.setup({
            hint = 'floating-big-letter',
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                  -- if the file type is one of following, the window will be ignored
                  filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                  -- if the buffer type is one of following, the window will be ignored
                  buftype = { 'terminal', "quickfix" },
              },
            },
          })
        end,
      },
    },
  },
}
