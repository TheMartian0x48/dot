vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.keymap.set("n", "<tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-tab>", ":bprev<CR>")

-- lsp
vim.keymap.set("n", "<F3>", vim.lsp.buf.format, {})
vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, {})



vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

--- telescope

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: buffer list" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: find files" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Telescope: find git files" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: help tags" })
vim.keymap.set("n", "<leader>fl", builtin.live_grep, { desc = "Telescope: live grep" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Telescope LSP document symbols" })

vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, { desc = "Telescope: List Definition" })


-- NvimTree

vim.keymap.set("n", "<leader>tg", ":NvimTreeFindFileToggle<CR>")
vim.keymap.set("n", "<leader>tr", ":NvimTreeRefresh<CR>")
vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>tf", ":NvimTreeFocus<CR>")
