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
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.neovide_opacity_point or 0.8))
  end
  -- -- Set transparency and background color (title bar color)
  -- vim.g.neovide_opacity = 0.0
  -- vim.g.neovide_opacity_point = 0.8
  -- vim.g.neovide_background_color = "#0f1117" .. alpha()
  -- -- Add keybinds to change transparency
  -- local change_transparency = function(delta)
  --   vim.g.neovide_opacity_point = vim.g.neovide_opacity_point + delta
  --   vim.g.neovide_background_color = "#0f1117" .. alpha()
  -- end
  -- vim.keymap.set({ "n", "v", "o" }, "<C-)>", function()
  --   change_transparency(0.01)
  -- end)
  -- vim.keymap.set({ "n", "v", "o" }, "<C-(>", function()
  --   change_transparency(-0.01)
  -- end)

  -- cd to commerce by default
  -- vim.cmd "cd ~/dev/commerce"
end

vim.cmd "echo 'set options'"
