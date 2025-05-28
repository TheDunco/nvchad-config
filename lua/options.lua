require "nvchad.options"

local o = vim.o
o.wrap = false
o.spell = true
o.spelllang = "en_us"
-- Disabled this to configure with the after/ftplugin folder
-- o.shiftwidth = 4

if vim.g.neovide then
  vim.print(vim.g.neovide_version)
  vim.o.guifont = "OverpassM Nerd Font Mono:h22"
  -- vim.g.neovide_cursor_vfx_mode = { "torpedo" }
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end
