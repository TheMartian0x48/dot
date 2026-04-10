return {
	"nvim-lualine/lualine.nvim",
	commit = "47f91c4",
	dependencies = { { "nvim-tree/nvim-web-devicons", commit = "746ffbb" } },
	event = "VeryLazy",
	opts = {
		options = {
			theme = "auto", -- adapt to colorscheme
			globalstatus = true,
		},
	},
}
