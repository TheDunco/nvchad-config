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

map("n", "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format current file with conform" })

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
end, { desc = "Find buffers (including hidden files)" })

map("n", "<leader>fmap", "<CMD>e ~/.config/nvim/lua/mappings.lua<CR>", { desc = "Edit mappings" })
map("n", "<leader>fmac", "<CMD>e ~/.config/nvim/lua/macros.lua<CR>", { desc = "Edit mappings" })

map("n", "<leader>fp", function()
  local optsWithIvyTheme = require("telescope.themes").get_ivy()
  require("telescope.builtin").diagnostics(optsWithIvyTheme)
end, { desc = "Find lsp problems (diagnostics)" })

-- Get a list of LSP references in Telescope
map("n", "gR", function()
  local optsWithIvyTheme = require("telescope.themes").get_ivy()
  require("telescope.builtin").lsp_references(optsWithIvyTheme)
end, { noremap = false })

-- Show the current full file name and path
map("n", "fn", "<CMD>echo expand ('%:p')<CR>")

-- Toggle virtual LSP lines
map("n", "<leader>tl", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

-- Toggle spell-checking
map("n", "<leader>ts", function()
  vim.o.spell = not vim.o.spell
end, { desc = "Toggle spell-checking" })

-- Source (reload/rerun) the current file/line/selection
map("n", "<leader>rf", "<CMD>source %<CR>", { desc = "Run (source) the current file" })
map("n", "<leader>rl", "<CMD>.lua<CR>", { desc = "Run (source) the current line" })
map("v", "<leader>rs", "<CMD>lua<CR>", { desc = "Run (source) the current selection" })

map("n", "<leader>ro", ":e #<CR>", { desc = "Reopen the last closed buffer " })

-- Yank the entire file (default nvchad command is <C-c> (control + c))
map("n", "y.", "<CMD>%y+<CR>", { desc = "Yank the entire file" })

-- Show the full file path of the tabline buffer in the command line
map("n", "<tab>", function()
  require("nvchad.tabufline").next()
  vim.cmd "echo expand ('%:p')"
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
  vim.cmd "echo expand ('%:p')"
end, { desc = "buffer goto prev" })

-- Open a new terminal as a buffer
map("n", "<leader>bt", function()
  vim.cmd "term"
  vim.o.nu = false
  vim.o.spell = false
end, { desc = "Open a terminal in a new buffer" })

print "✓ Done reading in custom mappings"
