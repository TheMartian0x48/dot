-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("nvim-tree").setup({
    hijack_cursor=true,
    view = {
        side="left",
        number=true,
        relativenumber=true,
        centralize_selection=true,
    },
    renderer = {
        group_empty=true,
        highlight_git="icon",
    }
});
