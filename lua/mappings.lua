require "nvchad.mappings"
local default_opts = { noremap = true }

local map = vim.keymap.set

-- Custom keymappings for me to be able to navigate with Colemak
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
end, { desc = "custom format files" })

-- Show hidden files in telescope find
map(
  "n",
  "<leader>ff",
  "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
  default_opts
)
map("n", "<leader>fr", "<cmd>lua require'telescope.builtin'.buffers({ show_all_buffers = true })<cr>", default_opts)

-- Get a list of LSP references in Telescope
map("n", "gR", "<CMD>Telescope lsp_references<CR>zz")

-- Show the current full filename and path
map("n", "fn", "<CMD>echo expand ('%:p')<CR>zz")
