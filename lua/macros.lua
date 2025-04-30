local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
-- Auto console.log with var name of selected text
vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pA', " .. esc .. "pA);" .. esc .. "")

-- -- Auto clsx wrapping
-- vim.fn.setreg("c", 'cf"<80><fd>5{clsx("..esc"pA)}"..esc"')

-- Replace quotes with backticks
vim.fn.setreg("b", 'vl"S`l' .. esc .. 'ids"')

-- Replace '' with "" (surround)
vim.fn.setreg("q", "vl'S\"ds'")

-- Template to disable an eslint rule
vim.fn.setreg("e", "O// eslint-disable-next-line -- ")

vim.fn.setreg("c", "L{/* " .. esc .. "A */}" .. esc .. "")

print "Done reading in custom macros"
