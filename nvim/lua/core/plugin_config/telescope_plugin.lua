require("telescope").setup({
	defaults = {
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = " ",
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key",
			},
		},
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.6,
			},
			width = 0.90,
			height = 0.90,
		},
	},
	pickers = {
		buffers = {
			previewer = false,
			layout_strategy = "vertical",
			layout_config = {
				vertical = {
					height = 0.6,
					prompt_position = "top",
					width = 0.6,
				},
			},
			mappings = {
				i = {
					["<C-d>"] = "delete_buffer",
				},
			},
			-- initial_mode = "normal",
		},
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	},
})
