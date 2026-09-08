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

local caps = vim.deepcopy(nvlsp.capabilities)
caps.textDocument.diagnostic = nil -- forces oxlint into push mode, so `run` is honored

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
  capabilities = caps,
  on_new_config = function(new_config, root_dir)
    new_config.init_options = {
      { workspaceUri = vim.uri_from_fname(root_dir), options = { run = "onSave" } },
    }
  end,

  on_init = function(client, result)
    nvlsp.on_init(client, result)
    local folders = client.workspace_folders or {}
    local settings = {}
    for _, f in ipairs(folders) do
      table.insert(settings, { workspaceUri = f.uri, options = { run = "onSave" } })
    end
    if #settings > 0 then
      client.notify("workspace/didChangeConfiguration", { settings = settings })
    end
  end,

  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    local last = -1
    vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
      buffer = bufnr,
      callback = function()
        local tick = vim.b[bufnr].changedtick
        if tick == last then
          return
        end
        last = tick
        client.notify("textDocument/didSave", {
          textDocument = { uri = vim.uri_from_bufnr(bufnr) },
        })
      end,
    })
  end,

  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "astro" },
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
