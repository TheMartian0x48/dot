return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Spectre",
	keys = {
		-- Open Spectre (Search & Replace Panel)
		{
			"<leader>rr",
			function()
				require("spectre").open()
			end,
			desc = "Replace in Files (Spectre)",
		},
		-- Search current word
		{
			"<leader>rw",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "Replace Current Word (Spectre)",
		},
		-- Search in current file
		{
			"<leader>rf",
			function()
				require("spectre").open_file_search()
			end,
			desc = "Replace in Current File (Spectre)",
		},
		-- Visual mode: search selected text
		{
			"<leader>rw",
			function()
				require("spectre").open_visual()
			end,
			mode = "v",
			desc = "Replace Selection (Spectre)",
		},
	},
	opts = {
		open_cmd = "vnew",
		live_update = false, -- auto execute search again when you write any file
		line_sep_start = "┌-----------------------------------------",
		result_padding = "¦  ",
		line_sep = "└-----------------------------------------",
		highlight = {
			ui = "String",
			search = "DiffChange",
			replace = "DiffDelete",
		},
		mapping = {
			-- Navigation & Selection
			["toggle_line"] = {
				map = "dd",
				cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
				desc = "toggle current item",
			},
			["enter_file"] = {
				map = "<CR>",
				cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
				desc = "go to file",
			},
			
			-- Actions
			["run_current_replace"] = {
				map = "R",
				cmd = "<cmd>lua require('spectre').replace_current_line()<CR>",
				desc = "replace current line",
			},
			["run_replace"] = {
				map = "<leader>R",
				cmd = "<cmd>lua require('spectre').replace_all()<CR>",
				desc = "replace all",
			},
			
			-- Utilities
			["send_to_qf"] = {
				map = "Q",
				cmd = "<cmd>lua require('spectre').change_options('send_to_qf')<CR>",
				desc = "send to quickfix",
			},
			["show_option_menu"] = {
				map = "?",
				cmd = "<cmd>lua require('spectre').show_options()<CR>",
				desc = "show options",
			},
			["change_view_mode"] = {
				map = "V",
				cmd = "<cmd>lua require('spectre').change_view()<CR>",
				desc = "change view mode",
			},
			
			-- Toggles (t prefix)
			["toggle_live_update"] = {
				map = "tu",
				cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
				desc = "toggle auto-update",
			},
			["toggle_ignore_case"] = {
				map = "ti",
				cmd = "<cmd>lua require('spectre').toggle_ignore_case()<CR>",
				desc = "toggle ignore case",
			},
			["toggle_ignore_hidden"] = {
				map = "th",
				cmd = "<cmd>lua require('spectre').toggle_ignore_hidden()<CR>",
				desc = "toggle hidden files",
			},
		},
		find_engine = {
			-- rg is the default find engine
			["rg"] = {
				cmd = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				options = {
					["ignore-case"] = {
						value = "--ignore-case",
						icon = "[I]",
						desc = "ignore case",
					},
					["hidden"] = {
						value = "--hidden",
						desc = "hidden file",
						icon = "[H]",
					},
				},
			},
		},
		replace_engine = {
			["sed"] = {
				cmd = "sed",
				args = nil,
			},
		},
		default = {
			find = {
				cmd = "rg",
				options = { "ignore-case" },
			},
			replace = {
				cmd = "sed",
			},
		},
	},
}
