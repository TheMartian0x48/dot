return {
	"folke/which-key.nvim",
	version = "v3.17.0",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {},
}
