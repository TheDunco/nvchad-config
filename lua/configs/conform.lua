local conform = require "conform"

conform.setup {
  formatters_by_ft = {
    lua = { "stylua" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    -- javascript = { "prettier" },
    typescript = { "prettier" },
    json = { "prettier" },
    javascriptreact = { "prettier" }, -- JSX
    typescriptreact = { "prettier" }, -- TSX
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}
