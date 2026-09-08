-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "html" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  fileTypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "tsgo", "--lsp", "--stdio" },
  init_options = { hostInfo = "neovim" },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayVariableTypeHints = true,
        -- Add other specific hint types here
      },
    },
  },
}

lspconfig.tailwindcss.setup {
  cmd = { "tailwindcss-language-server", "--stdio" },
  fileTypes = {
    "astro",
    "astro-markdown",
    "gohtml",
    "gohtmltmpl",
    "handlebars",
    "html",
    "htmlangular",
    "html-eex",
    "markdown",
    "mdx",
    "mustache",
    "php",
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "javascript",
    "javascriptreact",
    "rescript",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "templ",
  },
}

-- lspconfig.oxlint.setup {
--   cmd = { "oxlint", "--lsp" },
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescriptreact",
--     "typescript.tsx",
--   },
-- }

lspconfig.oxlint.setup {
  cmd = function(dispatchers, config)
    local cmd = "oxlint"
    if (config or {}).root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
      if vim.fn.executable(local_cmd) == 1 then
        cmd = local_cmd
      end
    end
    return vim.lsp.rpc.start({ cmd, "--lsp" }, dispatchers)
  end,

  capabilities = nvlsp.capabilities,
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  settings = {
    run = "onSave",
  },

  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "astro",
  },
}

-- lspconfig.eslint.setup {
--   cmd = { "vscode-eslint-language-server", "--stdio" },
--   capabilities = nvlsp.capabilities,
--   on_init = nvlsp.on_init,
--   on_attach = nvlsp.on_attach,
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescriptreact",
--     "typescript.tsx",
--   },
--   flags = {
--     debounce_text_changes = 500,
--   },
--   settings = {
--     run = "onSave",
--     problems = { shortenToSingleLine = true },
--     codeActionOnSave = { enable = false },
--     workingDirectory = { mode = "auto" },
--   },
-- }

vim.diagnostic.config { update_in_insert = false, virtual_text = true }
