require "nvchad.mappings"
local map = vim.keymap.set

-- Custom keymappings for me to be able to navigate hjkl with Colemak.
map({ "n", "v" }, "e", "<Up>")
map({ "n", "v" }, "n", "<Down>")
map({ "n", "v" }, "l", "i")
map({ "n", "v" }, "L", "I")
map({ "n", "v" }, "i", "l")
map({ "n", "v" }, "I", "L")
map({ "n", "v" }, "k", "nzz")
map({ "n", "v" }, "K", "Nzz")
-- map({ "n", "v" }, "n", "Nzz")
-- map({ "n", "v" }, "N", "Nzz")
map({ "n", "v" }, "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map({ "n", "v" }, "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

map("n", ";", ":", { desc = "CMD enter command mode" })

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
  require("telescope.builtin").find_files { hidden = true, file_ignore_patterns = { ".git/" } }
end)

map("n", "<leader>fw", function()
  require("telescope.builtin").live_grep {
    additional_args = function()
      return { "--hidden", "-g", "!**/.git/*", "--pcre2" }
    end,
  }
end)

-- Struggling to get this plugin to work with telescope for some reason
-- map("n", "<leader>~", "<CMD>TtTelescope<CR>", { silent = true, desc = "Transform Text" })

map("n", "<leader>fb", function()
  local optsWithIvyTheme = require("telescope.themes").get_ivy {
    show_all_buffers = true,
  }
  require("telescope.builtin").buffers(optsWithIvyTheme)
end, { desc = "Find buffers" })

map("n", "<leader>fl", function()
  require("telescope.builtin").lsp_document_symbols()
end)

map("n", "<leader>fmark", function()
  require("telescope.builtin").marks()
end)

map("n", "<leader>fgc", function()
  require("telescope.builtin").git_commits()
end)

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
map("n", "<leader>fn", "<CMD>echo expand ('%:p')<CR>")

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

map("n", "<leader>e", function()
  vim.cmd "Oil"
end, { desc = "Open Oil.nvim" })

-- NS File Cabinet
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

-- Other
map("n", "<leader>lsr", function()
  vim.cmd "LspRestart"
end, { desc = "Restart the LSP(s)" })

map("n", "<leader>alias", function()
  vim.cmd "e ~/.aliases.zshrc"
end, { desc = "Edit bash aliases" })

map("n", "<leader>qc", function()
  vim.cmd "cclose"
end, { desc = "Close the quickfix list " })

-- vs'S`ds'
-- Might have to set a macro in a register and run it instead
-- map("n", "<leader>sr'", function()
--   vim.cmd "vs'S`ds'"
-- end, { desc = "Replace ' with `" })

-- Strudel
local strudel = require "strudel"

vim.keymap.set("n", "<leader>sl", strudel.launch, { desc = "Launch Strudel" })
vim.keymap.set("n", "<leader>sq", strudel.quit, { desc = "Quit Strudel" })
vim.keymap.set("n", "<leader>st", strudel.toggle, { desc = "Strudel Toggle Play/Stop" })
vim.keymap.set("n", "<leader>su", strudel.update, { desc = "Strudel Update" })
vim.keymap.set("n", "<leader>ss", strudel.stop, { desc = "Strudel Stop Playback" })
vim.keymap.set("n", "<leader>sb", strudel.set_buffer, { desc = "Strudel set current buffer" })
vim.keymap.set("n", "<leader>sx", strudel.execute, { desc = "Strudel set current buffer and update" })

vim.keymap.set("n", "<leader>>", function()
  vim.cmd "vertical resize +10"
end)

vim.keymap.set("n", "<leader><", function()
  vim.cmd "vertical resize -10"
end)

print "✓ Done reading in custom mappings"
