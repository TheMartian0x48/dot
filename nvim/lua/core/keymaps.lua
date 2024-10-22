vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vanilla vim mapping
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.keymap.set("n", "<tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-tab>", ":bprev<CR>")

---------------------------------plugins key mapping

-- none-lsp
vim.keymap.set("n", "<F3>", vim.lsp.buf.format, {})

-- lsp
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, {})

-- NvimTree

vim.keymap.set("n", "<leader>tf", ":NvimTreeFindFileToggle<CR>")
vim.keymap.set("n", "<leader>tr", ":NvimTreeRefresh<CR>")
vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>")

--- telescope

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffer list" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Telescope find git files" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fl", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Telescope LSP document symbols" })

vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope git branch" })
vim.keymap.set("n", "<leader>gs", builtin.git_branches, { desc = "Telescope git status" })
vim.keymap.set("n", "<leader>gt", builtin.git_branches, { desc = "Telescope git stash" })
