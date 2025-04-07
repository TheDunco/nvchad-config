require "nvchad.mappings"
local default_opts = { noremap = true }

local map = vim.keymap.set

-- Custom keymappings for me to be able to navigate hjkl with Colemak.
map({ "n", "v" }, "e", "<Up>zz")
map({ "n", "v" }, "n", "<Down>zz")
map({ "n", "v" }, "l", "i")
map({ "n", "v" }, "L", "I")
map({ "n", "v" }, "i", "l")
map({ "n", "v" }, "I", "L")
map({ "n", "v" }, "k", "n")
map({ "n", "v" }, "K", "N")

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

map("n", "<leader>fc", function()
  local optsWithIvyTheme = require("telescope.themes").get_ivy {
    { cmd = vim.fn.stdpath "config" },
  }
  require("telescope.builtin").find_files(optsWithIvyTheme)
end, { desc = "Find files in neovim config dir" })

-- Get a list of LSP references in Telescope
map("n", "gR", function()
  local optsWithIvyTheme = require("telescope.themes").get_ivy()
  require("telescope.builtin").lsp_references(optsWithIvyTheme)
end, { noremap = false })
-- map("n", "gR", "<CMD>Telescope lsp_references<CR>zz")

-- Show the current full file name and path
map("n", "fn", "<CMD>echo expand ('%:p')<CR>zz")

-- Toggle virtual LSP lines
map("", "<leader>tl", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

-- Source (reload/rerun) the current file/line/selection
map("n", "<leader>rf", "<CMD>source %<CR>", { desc = "Run (source) the current file" })
map("n", "<leader>rl", ":.lua<CR>", { desc = "Run (source) the current line" })
map("v", "<leader>rs", ":lua<CR>", { desc = "Run (source) the current selection" })

map("n", "<leader>ro", ":e #<CR>", { desc = "Reopen the last closed buffer " })

-- Yank the entire file
map("", "y.", "<CMD>%y+<CR>", { desc = "Yank the entire file" })

print "✓ Done reading in custom mappings"
