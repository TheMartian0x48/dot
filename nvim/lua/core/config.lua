vim.o.timeout = true
vim.o.timeoutlen = 300

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.cursorline = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 50

vim.g.mapleader = " "

vim.opt.fillchars = {
    eob = " ",
    fold = " "
}
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.g.markdown_folding = 1 -- enable markdown folding

-- already present in status line
vim.opt.showmode = false

vim.g.gruvbox_baby_background_color="dark";


-- support of ftlh 
vim.filetype.add({
    extension = {
        ftlh = "html",
        jte = "html"
    }
})
