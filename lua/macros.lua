-- Auto console.log with var name of selected text
vim.fn.setreg("l", "yoconsole.log('^[pA', ^[pA);^[")
