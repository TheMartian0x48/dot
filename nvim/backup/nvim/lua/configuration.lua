vim.wo.conceallevel = 2
-- timeout
vim.o.timeout = true
vim.o.timeoutlen = 300

-- number
vim.opt.number = true
vim.opt.relativenumber = true

-- indent
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- backup
vim.opt.backup = false
vim.opt.swapfile = false

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 50

vim.g.mapleader = " "

vim.opt.fillchars = {
    eob = " ",
    fold = " ",
}

-- fold
vim.g.markdown_folding = 1 -- enable markdown folding
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = "indent"

-- already present in status line
vim.opt.showmode = false

vim.g.gruvbox_baby_background_color = "dark"

-- support of ftlh
vim.filetype.add({
    extension = {
        ftlh = "html",
        jte = "html",
    },
})

vim.filetype.add({
    pattern = {
        [".*%.blade%.php"] = "blade",
    },
})
