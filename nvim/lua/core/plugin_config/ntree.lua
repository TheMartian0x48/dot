-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local function centerFloat()
	local win_width = 100
	local win_height = 30

	local screen_width = vim.api.nvim_get_option("columns")
	local screen_height = vim.api.nvim_get_option("lines")

	if screen_width < win_width then
		win_width = math.max(10, screen_width - 10)
	end

	if screen_height < win_height then
		win_height = math.max(10, screen_height - 10)
	end

	local col = math.ceil((screen_width - win_width) / 2)
	local row = math.ceil((screen_height - win_height) / 2)

	return {
		relative = "editor",
		width = win_width,
		height = win_height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}
end

require("nvim-tree").setup({
	disable_netrw = true,
	-- hijack_cursor = true,
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	view = {
		number = true,
		relativenumber = true,
		centralize_selection = true,
		preserve_window_proportions = true,
        side = "right",
        width = 40,
		-- float = {
		-- 	enable = true,
		-- 	quit_on_focus_loss = true,
		-- 	open_win_config = centerFloat,
		-- },
	},
	renderer = {
		-- root_folder_label = false,
		indent_width = 2,
		group_empty = true,
		highlight_git = "icon",
		highlight_diagnostics = "icon",
		highlight_opened_files = "icon",
		highlight_modified = "icon",
		highlight_hidden = "icon",
		highlight_bookmarks = "icon",
		highlight_clipboard = "name",
		icons = {
			glyphs = {
				default = "󰈚",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
				},
				git = { unmerged = "" },
			},
		},
	},
	diagnostics = {
		enable = true,
	},
	filters = {
		custom = { "\\.git\\>" },
	},
})
