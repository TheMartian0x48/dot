return {
	"folke/trouble.nvim",
	version = "v3.7.1",
	dependencies = { { "nvim-tree/nvim-web-devicons", commit = "746ffbb" } },
	cmd = "Trouble",
	opts = {
		modes = {
			preview_float = {
				mode = "diagnostics",
				preview = {
					type = "float",
					relative = "editor",
					border = "rounded",
					title = "Preview",
					title_pos = "center",
					position = { 0, -2 },
					size = { width = 0.3, height = 0.3 },
					zindex = 200,
				},
			},
		},
	},
}
