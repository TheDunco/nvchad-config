require "nvchad.mappings"
local map = vim.keymap.set

-- Custom keymappings for me to be able to navigate hjkl with Colemak.
map({ "n", "v" }, "e", "<Up>zz")
map({ "n", "v" }, "n", "<Down>zz")
map({ "n", "v" }, "l", "i")
map({ "n", "v" }, "L", "I")
map({ "n", "v" }, "i", "l")
map({ "n", "v" }, "I", "L")
map({ "n", "v" }, "k", "nzz")
map({ "n", "v" }, "K", "Nzz")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- -- F jump/navigation remaps
-- map("n", "<leader>,", function()
--   -- what to put?
-- end, { desc = "Previous f jump" })
--
-- map("n", "<leader>.", function()
--   -- what to put?
-- end, { desc = "Next f jump" })

map("n", "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
  vim.cmd "echo 'Formatted file'"
end, { desc = "Format current file with conform.nvim" })

-- TELESCOPE --
-- Show hidden files in telescope find
map("n", "<leader>ff", function()
  local optsWithIvyTheme = require("telescope.themes").get_ivy {
    {
      find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
      desc = "Find files (including hidden)",
    },
  }
  require("telescope.builtin").find_files(optsWithIvyTheme)
end)

map("n", "<leader>fb", function()
  local optsWithIvyTheme = require("telescope.themes").get_ivy {
    show_all_buffers = true,
  }
  require("telescope.builtin").buffers(optsWithIvyTheme)
end, { desc = "Find buffers" })

map("n", "<leader>map", "<CMD>e ~/.config/nvim/lua/mappings.lua<CR>", { desc = "Edit mappings" })
map("n", "<leader>mac", "<CMD>e ~/.config/nvim/lua/macros.lua<CR>", { desc = "Edit mappings" })
map("n", "<leader>lsp", "<CMD>e ~/.config/nvim/lua/configs/lspconfig.lua<CR>", { desc = "Edit lsp config" })

map("n", "<leader>fp", function()
  local optsWithIvyTheme = require("telescope.themes").get_ivy()
  require("telescope.builtin").diagnostics(optsWithIvyTheme)
end, { desc = "Find lsp problems (diagnostics)" })

map("n", "<leader>fx", require("telescope.builtin").resume, {
  noremap = true,
  silent = true,
  desc = "Resume last telescope search",
})

map("n", "<leader>f*", function()
  require("telescope.builtin").live_grep { default_text = vim.fn.expand "<cword>" }
end, { desc = "Live grep the symbol under the cursor in Telescope" })

-- Get a list of LSP references in Telescope
map("n", "gR", function()
  local optsWithIvyTheme = require("telescope.themes").get_ivy()
  require("telescope.builtin").lsp_references(optsWithIvyTheme)
end, { noremap = false, desc = "Open LSP references in Telescope" })

-- Show the current full file name and path
map("n", "fn", "<CMD>echo expand ('%:p')<CR>")

-- Toggle virtual LSP lines
map("n", "<leader>tl", require("lsp_lines").toggle, { desc = "Toggle virtual lsp_lines" })

-- Toggle spell-checking
map("n", "<leader>ts", function()
  vim.o.spell = not vim.o.spell
end, { desc = "Toggle spell-checking" })

-- Source (reload/rerun) the current file/line/selection
map("n", "<leader>rf", "<CMD>source %<CR>", { desc = "Run (source) the current file" })
map("n", "<leader>rl", "<CMD>.lua<CR>", { desc = "Run (source) the current line" })
map("v", "<leader>rs", "<CMD>lua<CR>", { desc = "Run (source) the current selection" })

map("n", "<leader>ro", ":e #<CR>", { desc = "Go to the last buffer" })

-- Yank the entire file (default nvchad command is <C-c> (control + c))
map("n", "y.", "<CMD>%y+<CR>", { desc = "Yank the entire file" })

-- Show the full file path of the tabline buffer in the command line
map("n", "<tab>", function()
  require("nvchad.tabufline").next()
  vim.cmd "echo expand ('%:p')"
end, { desc = "Buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
  vim.cmd "echo expand ('%:p')"
end, { desc = "Buffer goto prev" })

-- Open a new terminal as a buffer
map("n", "<leader>bt", function()
  vim.cmd "term"
  vim.o.nu = false
  vim.o.spell = false
end, { desc = "Open a terminal in a new buffer" })

map("n", "<leader>lint", function()
  vim.cmd "EslintFixAll"
  vim.cmd "echo 'Fixed all autofixable eslint issues'"
end, { desc = "Fix all autofixable eslint issues" })

-- Oil
map("n", "<leader>o", function()
  vim.cmd "Oil --float"
end, { desc = "Open Oil.nvim (float)" })

-- TSTools
-- map("n", "<leader>ia", function()
--   vim.cmd "TSToolsAddMissingImports"
--   vim.cmd "echo 'Added missing imports ✓'"
-- end)
--
-- map("n", "<leader>ir", function()
--   vim.cmd "TSToolsRemoveUnusedImports"
--   vim.cmd "echo 'Removed unused imports ✓'"
-- end)

-- map("n", "gd", "<CMD>TSToolsGoToSourceDefinition<CR>")

-- File Cabinet
map("n", "<leader>up", function()
  vim.cmd "term pnpm ns:upload %:t"
end, { desc = "Upload the current file to the file cabinet" })

map("n", "<leader>imp", function()
  vim.cmd "term pnpm ns:import %:t"
end, { desc = "Import the current file from the file cabinet" })

-- For working in envs where the setup is to format on save via ESLint
map("n", "<leader>ww", function()
  vim.cmd "noautocmd write"
end, { desc = "Write without running autocmds (conform)" })

map("n", "<leader>lw", function()
  vim.cmd "EslintFixAll"
  vim.cmd "echo 'Linted'"
  vim.cmd "noautocmd write"
end, { desc = "Lint, then write without autocmds" })

-- Smear cursor toggling
map("n", "<leader>tc", function()
  require("smear_cursor").enabled = not require("smear_cursor").enabled
end, { desc = "Toggle cursor smearing" })

print "✓ Done reading in custom mappings"
