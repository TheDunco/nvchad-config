return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "VeryLazy",
    config = function()
      require("lsp_lines").setup()
    end,
  },
  -- Format on save
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    config = function()
      require "configs.conform"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPre",
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
      }
    end,
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true, -- if you want to enable the plugin
      message_template = " <author> • <date> • <summary> <<sha>>", -- template for the blame message, check the Message template section for more options
      date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
      delay = 1000, -- ms
      max_commit_summary_length = 65,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    -- Trying to get global ivy theme
    -- config = function()
    --   require("telescope").setup {
    --     pickers = {
    --       find_files = {
    --         theme = "ivy",
    --       },
    --     },
    --   }
    -- end,
    opts = {
      defaults = {
        -- Trying to add the nvchad defaults here such that I can add this wrap_results
        wrap_results = true,
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        -- Should move all mappings here
        mappings = {
          n = { ["q"] = require("telescope.actions").close },
        },
      },

      extensions_list = { "themes", "terms" },
      extensions = {},
    },
  },
}
