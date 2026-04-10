local M = {}

--- Get the current visual selection text
function M.get_visual_selection()
	vim.cmd('noau normal! "vy')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})
	return text:gsub("\n", "")
end

--- Pick a directory via fuzzy finder, then run callback with the selected directory
---@param title string prompt title for the directory picker
---@param callback fun(dir: string) called with the selected directory path
local function pick_directory(title, callback)
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local dirs = vim.fn.systemlist("find . -type d -not -path '*/.git/*' -not -path '*/node_modules/*'")

	pickers.new({}, {
		prompt_title = title,
		finder = finders.new_table({ results = dirs }),
		sorter = conf.generic_sorter({}),
		attach_mappings = function(prompt_bufnr)
			actions.select_default:replace(function()
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				if selection then
					callback(selection[1])
				end
			end)
			return true
		end,
	}):find()
end

--- Pick a directory, then live_grep in it
function M.grep_in_directory()
	pick_directory("Select Directory to Search", function(dir)
		require("telescope.builtin").live_grep({ search_dirs = { dir } })
	end)
end

--- Pick a directory, then find_files in it
function M.find_in_directory()
	pick_directory("Select Directory to Find Files", function(dir)
		require("telescope.builtin").find_files({ search_dirs = { dir }, no_ignore = true })
	end)
end

--- Pick a directory, then grep word under cursor in it
function M.grep_word_in_directory()
	pick_directory("Select Directory to Grep Word", function(dir)
		require("telescope.builtin").grep_string({ search_dirs = { dir } })
	end)
end

--- Pick a directory, then grep visual selection in it
function M.grep_selection_in_directory()
	local text = M.get_visual_selection()
	pick_directory("Select Directory to Grep Selection", function(dir)
		require("telescope.builtin").grep_string({ search = text, search_dirs = { dir } })
	end)
end

return M
