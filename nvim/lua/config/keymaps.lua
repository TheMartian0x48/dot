-- ==========================================
-- Keymaps - All keybindings in one place
-- ==========================================

local map = vim.keymap.set

-- ==========================================
-- Basic Operations
-- ==========================================
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save File" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>q!<CR>", { desc = "Force Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- ==========================================
-- Window Navigation & Management
-- ==========================================
map("n", "<C-h>", "<C-w>h", { desc = "Move to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to Right Window" })

-- Resize Windows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase Window Width" })

-- ==========================================
-- Text Editing
-- ==========================================
-- Move Lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- ==========================================
-- Terminal (Toggleterm)
-- ==========================================
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Float terminal" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Horizontal terminal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Vertical terminal" })
map("n", "<leader>tl", "<cmd>lua _lazygit_toggle()<CR>", { desc = "Toggle Lazygit" })

-- Terminal mode mappings
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Move to left window" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Move to down window" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Move to up window" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Move to right window" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ==========================================
-- UI Toggles
-- ==========================================
-- Diagnostics
map("n", "<leader>ud", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

map("n", "<leader>uD", "<cmd>Telescope notify<CR>", { desc = "Dismiss notifications" })

map("n", "<leader>uv", function()
	vim.diagnostic.config({
		virtual_text = not vim.diagnostic.config().virtual_text
	})
end, { desc = "Toggle diagnostic virtual text" })

-- Formatting
local format_enabled = true
map("n", "<leader>uf", function()
	vim.b.disable_autoformat = not vim.b.disable_autoformat
	print("Buffer autoformat: " .. (vim.b.disable_autoformat and "disabled" or "enabled"))
end, { desc = "Toggle autoformat (buffer)" })

map("n", "<leader>uF", function()
	vim.g.disable_autoformat = not vim.g.disable_autoformat
	print("Global autoformat: " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
end, { desc = "Toggle autoformat (global)" })

-- Line wrap
map("n", "<leader>uw", function()
	vim.wo.wrap = not vim.wo.wrap
	print("Line wrap: " .. (vim.wo.wrap and "enabled" or "disabled"))
end, { desc = "Toggle wrap" })

-- Line numbering (cycle through relative, absolute, none)
map("n", "<leader>un", function()
	if vim.wo.number and vim.wo.relativenumber then
		vim.wo.relativenumber = false
		print("Line numbers: absolute")
	elseif vim.wo.number then
		vim.wo.number = false
		print("Line numbers: none")
	else
		vim.wo.number = true
		vim.wo.relativenumber = true
		print("Line numbers: relative")
	end
end, { desc = "Cycle line numbering" })

-- LSP Inlay hints
map("n", "<leader>uh", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	print("Inlay hints: " .. (vim.lsp.inlay_hint.is_enabled() and "enabled" or "disabled"))
end, { desc = "Toggle inlay hints" })

-- Spellcheck
map("n", "<leader>us", function()
	vim.wo.spell = not vim.wo.spell
	print("Spellcheck: " .. (vim.wo.spell and "enabled" or "disabled"))
end, { desc = "Toggle spellcheck" })

-- Background (dark/light)
map("n", "<leader>ub", function()
	vim.o.background = vim.o.background == "dark" and "light" or "dark"
	print("Background: " .. vim.o.background)
end, { desc = "Toggle background" })

-- Signcolumn
map("n", "<leader>ug", function()
	vim.wo.signcolumn = vim.wo.signcolumn == "yes" and "no" or "yes"
	print("Signcolumn: " .. vim.wo.signcolumn)
end, { desc = "Toggle signcolumn" })

-- Statusline
map("n", "<leader>ul", function()
	vim.o.laststatus = vim.o.laststatus == 0 and 3 or 0
	print("Statusline: " .. (vim.o.laststatus == 0 and "hidden" or "visible"))
end, { desc = "Toggle statusline" })

-- Tabline (bufferline)
map("n", "<leader>ut", function()
	vim.o.showtabline = vim.o.showtabline == 0 and 2 or 0
	print("Tabline: " .. (vim.o.showtabline == 0 and "hidden" or "visible"))
end, { desc = "Toggle tabline" })

-- ==========================================
-- Quickfix & Location Lists
-- ==========================================
-- Quickfix (Global list)
map("n", "<leader>xq", "<cmd>copen<CR>", { desc = "Open Quickfix" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<CR>", { desc = "Prev quickfix" })
map("n", "]Q", "<cmd>clast<CR>", { desc = "Last quickfix" })
map("n", "[Q", "<cmd>cfirst<CR>", { desc = "First quickfix" })

-- Location List (Window-local)
map("n", "<leader>xl", "<cmd>lopen<CR>", { desc = "Open Location List" })
map("n", "]l", "<cmd>lnext<CR>", { desc = "Next location" })
map("n", "[l", "<cmd>lprev<CR>", { desc = "Prev location" })
map("n", "]L", "<cmd>llast<CR>", { desc = "Last location" })
map("n", "[L", "<cmd>lfirst<CR>", { desc = "First location" })

-- ==========================================
-- Trouble (Better Diagnostics UI)
-- ==========================================
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<CR>", { desc = "Symbols (Trouble)" })
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", { desc = "LSP Definitions / references / ... (Trouble)" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })

-- ==========================================
-- Session Management
-- ==========================================
map("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore Session" })
map("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session" })
map("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't Save Current Session" })

-- ==========================================
-- Buffer Management (Bufferline)
-- ==========================================
-- Buffer Navigation
map("n", "]b", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map("n", "<leader>bp", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

-- Buffer Movement
map("n", ">b", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
map("n", "<b", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })

-- Buffer Picker & Actions
map("n", "<leader>bb", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })
map("n", "<leader>bf", "<cmd>Telescope buffers<CR>", { desc = "Fuzzy find buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<CR>", { desc = "Force delete buffer" })
map("n", "<leader>bc", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
map("n", "<leader>bC", "<cmd>bufdo bdelete<CR>", { desc = "Close all buffers" })
map("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close buffers to left" })
map("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Close buffers to right" })

-- Buffer Splits (using Telescope)
map("n", "<leader>b\\", "<cmd>Telescope buffers<CR>", { desc = "Buffer splits (use <C-x>/<C-v>)" })
map("n", "<leader>b|", "<cmd>Telescope buffers<CR>", { desc = "Buffer splits (use <C-x>/<C-v>)" })

-- Buffer Sorting
map("n", "<leader>bse", "<cmd>BufferLineSortByExtension<CR>", { desc = "Sort by extension" })
map("n", "<leader>bsd", "<cmd>BufferLineSortByDirectory<CR>", { desc = "Sort by directory" })
map("n", "<leader>bsr", "<cmd>BufferLineSortByRelativeDirectory<CR>", { desc = "Sort by relative path" })

-- ==========================================
-- File Explorer (NvimTree)
-- ==========================================
map("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer Toggle" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Explorer Find File" })

-- ==========================================
-- Git (Gitsigns)
-- ==========================================
map("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next git hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Prev git hunk" })
map("n", "<leader>gj", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next hunk" })
map("n", "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Prev hunk" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
map("v", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })
map("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map("v", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "Reset buffer" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Blame line" })
map("n", "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle blame line" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { desc = "Diff this" })
map("n", "<leader>gD", "<cmd>Gitsigns toggle_deleted<CR>", { desc = "Toggle deleted" })

-- ==========================================
-- Telescope (Fuzzy Finder)
-- ==========================================
-- Files & Buffers
map("n", "<leader>s<CR>", "<cmd>Telescope resume<CR>", { desc = "Resume Previous Search" })
map("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
map("n", "<leader>sF", "<cmd>Telescope find_files hidden=true no_ignore=true<CR>", { desc = "Find Files (Hidden)" })
map("n", "<leader>sg", "<cmd>Telescope git_files<CR>", { desc = "Git Tracked Files" })
map("n", "<leader>so", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files" })

-- Search & Grep
map("n", "<leader>sw", "<cmd>Telescope grep_string<CR>", { desc = "Word at Cursor" })
map("n", "<leader>s/", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>sG", "<cmd>Telescope live_grep additional_args={'--hidden','--no-ignore'}<CR>", { desc = "Live Grep (Hidden)" })
map("n", "<leader>sl", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Lines in Buffer" })

-- Vim Helpers
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })
map("n", "<leader>sm", "<cmd>Telescope man_pages<CR>", { desc = "Man Pages" })
map("n", "<leader>sc", "<cmd>Telescope commands<CR>", { desc = "Commands" })
map("n", "<leader>s'", "<cmd>Telescope marks<CR>", { desc = "Marks" })
map("n", "<leader>sr", "<cmd>Telescope registers<CR>", { desc = "Registers" })
map("n", "<leader>sn", "<cmd>Telescope notify<CR>", { desc = "Notifications" })

-- Appearance
map("n", "<leader>ss", "<cmd>Telescope colorscheme<CR>", { desc = "Colorschemes" })

-- ==========================================
-- LSP Keymaps (Global)
-- ==========================================
map('n', '<leader>li', '<cmd>LspInfo<CR>', { desc = "LSP Info" })
map('n', 'gl', vim.diagnostic.open_float, { desc = "Line diagnostics" })
map('n', '<leader>ld', vim.diagnostic.open_float, { desc = "Line diagnostics" })
map('n', '<leader>lD', '<cmd>Telescope diagnostics<CR>', { desc = "All Diagnostics" })

-- Diagnostic Navigation
map('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev diagnostic" })
map('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
map('n', '[e', function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Prev error" })
map('n', ']e', function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Next error" })
map('n', '[w', function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN }) end, { desc = "Prev warning" })
map('n', ']w', function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN }) end, { desc = "Next warning" })

-- ==========================================
-- LSP Keymaps (Buffer-specific, set on LspAttach)
-- ==========================================
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		
		-- Navigation (Standard LSP
		map('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
		map('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
		map('n', 'gy', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Go to type definition" })
		map('n', 'gri', vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go to implementation" })
		map('n', 'grr', vim.lsp.buf.references, { buffer = ev.buf, desc = "References" })
		map('n', '<leader>lR', vim.lsp.buf.references, { buffer = ev.buf, desc = "References" })
		
		-- Information
		map('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover documentation" })
		map('n', '<leader>lh', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature help" })
		
		-- Actions
		map('n', 'grn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
		map('n', '<leader>lr', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
		map({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code action" })
		map({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code action" })
		map('n', '<leader>lA', function()
			vim.lsp.buf.code_action({ context = { only = { "source" } } })
		end, { buffer = ev.buf, desc = "Source action" })
		
		-- Formatting
		map('n', '<leader>lf', function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { buffer = ev.buf, desc = "Format document" })
		
		-- Symbols
		map('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<CR>', { buffer = ev.buf, desc = "Document symbols" })
		map('n', '<leader>lG', '<cmd>Telescope lsp_workspace_symbols<CR>', { buffer = ev.buf, desc = "Workspace symbols" })
		map('n', 'gO', '<cmd>Telescope lsp_document_symbols<CR>', { buffer = ev.buf, desc = "Document symbols outline" })
		
		-- Workspace
		map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = "Add workspace folder" })
		map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = "Remove workspace folder" })
		map('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = ev.buf, desc = "List workspace folders" })
	end,
})

