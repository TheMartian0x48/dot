return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Test adapters
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-jest",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-go")({
						recursive_run = true,
					}),
					require("neotest-python")({
						dap = { justMyCode = false },
						runner = "pytest",
					}),
					require("neotest-jest")({
						jestCommand = "npm test --",
						cwd = function()
							return vim.fn.getcwd()
						end,
					}),
				},
				status = {
					virtual_text = true,
					signs = true,
				},
				output = {
					enabled = true,
					open_on_run = false,
				},
				quickfix = {
					enabled = true,
					open = false,
				},
				icons = {
					passed = "✓",
					failed = "✗",
					running = "⟳",
					skipped = "○",
					unknown = "?",
				},
			})
		end,
	},
}
