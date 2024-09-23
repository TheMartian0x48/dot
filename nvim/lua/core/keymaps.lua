vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- vanilla vim mapping
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('n', '<tab>', ':bnext<CR>');
vim.keymap.set('n', '<S-tab>', ':bprev<CR>');
---------------------------------plugins key mapping
-- none-lsp
vim.keymap.set('n', '<F3>', vim.lsp.buf.format, {})

-- lsp
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, {})
-- NvimTree

vim.keymap.set('n', '<C-\\>', ':NvimTreeToggle<CR>')
--vim.keymap.set('n', '<C-]>',  ':NvimTreeFocus<CR>')
vim.keymap.set('n', '<F12>',  ':NvimTreeFindFileToggle<CR>')

