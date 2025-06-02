-- My personal changes to the LazyVim Core plugins
local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")
local cmp = require("cmp")
local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        cache_picker = {
          num_pickers = 32,
          ignore_empty_prompt = true,
        },
        -- layout_strategy = "vertical",
        -- layout_config = {
        --   vertical = { height = 0.95, width = 0.9 },
        -- },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-d>"] = actions.results_scrolling_down,
            ["<C-u>"] = actions.results_scrolling_up,
            ["<PageUp>"] = actions.preview_scrolling_up,
            ["<PageDown>"] = actions.preview_scrolling_down,
            ["<C-p>"] = layout.toggle_preview,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-d>"] = actions.results_scrolling_down,
            ["<C-u>"] = actions.results_scrolling_up,
            ["<PageUp>"] = actions.preview_scrolling_up,
            ["<PageDown>"] = actions.preview_scrolling_down,
            ["<C-p>"] = layout.toggle_preview,
            ["q"] = {
              actions.close,
              type = "action",
              opts = { nowait = true, silent = true },
            },
            ["<C-c>"] = {
              actions.close,
              type = "action",
              opts = { nowait = true, silent = true },
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>st",
        function()
          require("telescope.builtin").live_grep({ cwd = false })
        end,
        desc = "Grep (root dir)",
      },
      {
        "<leader>sf",
        function()
          require("telescope.builtin").find_files({ cwd = false })
        end,
        desc = "Find Files (cwd)",
      },
      {
        "<leader>se",
        function()
          require("telescope.builtin").git_status({ cwd = false })
        end,
        desc = "Search Git Status Files",
      },
      {
        "<leader><leader>",
        function()
          require("telescope.builtin").buffers({ sort_mru = true })
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
            "m",
            true
          )
        end,
        desc = "Buffers (mru)",
      },
      {
        "<leader>r",
        function()
          require("telescope.builtin").resume()
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
            "m",
            true
          )
        end,
        desc = "[r]esume last search",
      },
      {
        "<leader>R",
        function()
          require("telescope.builtin").pickers()
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
            "m",
            true
          )
        end,
        desc = "See [R]ecent telescope pickers",
      },
    },
  },
  { -- I want <C-j> and <C-k> to scroll the cmp menu
    -- Thu Apr 24 05:38:02 PM PDT 2025 nvim-cmp replaced by blink.cmp
    -- Fri Apr 25 04:00:04 PM PDT 2025, agh, turns out i want to use nvim.cmp (blink seems slow for clangd completions)
    "hrsh7th/nvim-cmp",
    opts = {
      performance = {
        fetching_timeout = 25000, -- 25 seconds (pro gemini model might take awhile)
      },
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
        -- ["<A-y>"] = require("minuet").make_cmp_map(),
      }),
    },
  },
  {
    "Saghen/blink.cmp",
    opts = {
      keymap = {
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
    },
  },
  { -- I don't use this feature and it hijacks visual mode <BS> (idk if it does)
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>Q",
          node_incremental = "v",
          node_decremental = "V",
        },
      },
    },
  },
  -- add my favorite colorschemes
  { -- light mode
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
    },
  },
  { -- dark mode
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
      theme = "wave", -- Load "wave" theme when 'background' option is not set
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },
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
      colorscheme = "kanagawa-wave", -- dark mode
      -- colorscheme = "catppuccin-latte", -- light mode
      -- colorscheme = "kanagawa-wave", -- dark mode
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
      close_if_last_window = true,
      filesystem = {
        follow_current_file = {
          enabled = false,
        },
        hijack_netrw_behavior = "disabled",
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
          },
          never_show = {},
        },
      },
      window = {
        mappings = {
          ["w"] = "open_with_window_picker",
          ["q"] = "close_window",
          ["<C-b>"] = "",
          ["<Space>"] = "toggle_node",
        },
      },
    },
    dependencies = {
      {
        "s1n7ax/nvim-window-picker",
        version = "*",
        config = function()
          require("window-picker").setup({
            highlights = {
              statusline = {
                focused = {
                  fg = "#ededed",
                  bg = "#3c2642",
                  bold = true,
                },
                unfocused = {
                  fg = "#ededed",
                  bg = "#3c2642",
                  bold = true,
                },
              },
            },
            hint = "statusline-winbar",
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      numhl = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        basedpyright = {},
        ruff = { mason = false, autostart = false }, -- don't auto-install/use ruff
        pyright = { mason = false, autostart = false }, -- or pyright...
      },
    },
  },
  { "nvim-treesitter/nvim-treesitter-context" },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "basedpyright",
        "black",
        "clangd",
      },
    },
  },
  { "folke/noice.nvim", opts = { enabled = false } },
  {
    "folke/snacks.nvim",
    opts = {
      notifier = { enabled = false },
      scroll = { enabled = false },
    },
  },
  { "folke/which-key.nvim", opts = { preset = "modern" } },
}
