return {
	"nvim-telescope/telescope.nvim",
	version = "v0.2.1",
	dependencies = { { "nvim-lua/plenary.nvim", commit = "b9fd522" } },
	cmd = "Telescope",
	opts = {
		defaults = {
			file_ignore_patterns = { "node_modules", ".git" },
			path_display = { "truncate", "smart" }, -- Shows filename first, then truncated path
			layout_strategy = "horizontal",
			layout_config = {
				width = 0.9,        -- Use 90% of the screen width
				preview_width = 0.4, -- Preview takes 40% of available space
			},
		},
		pickers = {
			colorscheme = {
				enable_preview = true,
			},
		},
	},
}
