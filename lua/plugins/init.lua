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
    event="VeryLazy",
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
  },
}
