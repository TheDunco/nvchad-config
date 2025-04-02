-- local options = {
--   formatters_by_ft = {
--     lua = { "stylua" },
--     css = { "prettier" },
--     scss = { "prettier" },
--     html = { "prettier" },
--     javascript = { "prettier" },
--     javascriptreact = { "prettier" },
--     typescript = { "prettier" },
--     typescriptreact = { "prettier" },
--   },
--
--
--   format_on_save = {
--     -- These options will be passed to conform.format()
--     timeout_ms = 500,
--     lsp_fallback = true,
--   },
--   -- format_after_save = {
--   --   lsp_fallback = true,
--   -- }
-- }
--
-- return options

local conform = require "conform"

conform.setup {
  formatters_by_ft = {
    lua = { "stylua" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    json = { "prettier" },
    javascriptreact = { "prettier" }, -- JSX
    typescriptreact = { "prettier" }, -- TSX
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
