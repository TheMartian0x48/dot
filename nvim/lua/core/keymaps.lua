vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vanilla vim mapping
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.keymap.set("n", "<tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-tab>", ":bprev<CR>")

-- Split
vim.keymap.set("n", "<Leader>h", ":<C-u>split<CR>")
vim.keymap.set("n", "<Leader>v", ":<C-u>vsplit<CR>")

-- Switching windows
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>",  "<C-w>k")
vim.keymap.set("n", "<C-l>",  "<C-w>l")
vim.keymap.set("n", "<C-h>",  "<C-w>h")

-- Buffer nav
vim.keymap.set("n", "<leader>q", ":bp<CR>")
vim.keymap.set("n", "<leader>w", ":bn<CR>")

-- Close buffer
vim.keymap.set("n", "<leader>e", ":bd<CR>")
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

vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, { desc = "Telescope live grep" })

------ GIT
vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope git baranch" })
vim.keymap.set("n", "<leader>gs", builtin.git_branches, { desc = "Telescope git status" })
vim.keymap.set("n", "<leader>gt", builtin.git_branches, { desc = "Telescope git stash" })

--- trouble
local trouble = require("trouble")
vim.keymap.set("n", "<leader>ad", function()
	trouble.open({
		mode = "lsp_document_symbols",
		focus = true,
		win = {
			type = "split",
			position = "right",
			size = 0.4,
		},
	})
end, { desc = "Trouble lsp_document_symbols" })

local function trouble_bottom_win_config()
	return {
		focus = true,
		win = {
			type = "split",
			position = "bottom",
			size = 0.4,
		},
	}
end

local trouble_lsp = function()
	local config = trouble_bottom_win_config()
	config.mode = "lsp"
	return trouble.open(config)
end

local trouble_lsp_refernces = function()
	local config = trouble_bottom_win_config()
	config.mode = "lsp_references"
	return trouble.open(config)
end

local trouble_diagnostics = function()
	local config = trouble_bottom_win_config()
	config.mode = "diagnostics"
	return trouble.open(config)
end
vim.keymap.set("n", "<leader>ar", trouble_lsp_refernces, { desc = "Trouble lsp_references" })
vim.keymap.set("n", "<leader>al", trouble_lsp, { desc = "Trouble all lsp" })
vim.keymap.set("n", "<leader>ax", trouble_diagnostics, { desc = "Trouble diagnostics" })
