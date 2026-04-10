return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Adapters
			"nvim-neotest/neotest-go", -- Golang (Classic)
			"lawrence-laz/neotest-zig", -- Zig
		},
		config = function()
			-- Setup neotest
			require("neotest").setup({
				adapters = {
					require("neotest-go"),
					require("neotest-zig"),
				},
				-- Optional: Configure consumer to open the summary window automatically
				-- status = { virtual_text = true },
				output = { open_on_run = true },
				quickfix = {
					open = function()
						vim.cmd("copen")
					end,
				},
			})

			-- Keymaps
			local map = vim.keymap.set
			local opts = { noremap = true, silent = true, desc = "Neotest" }

			map("n", "<leader>nn", function()
				require("neotest").run.run()
			end, { desc = "Test Nearest" })

			map("n", "<leader>nf", function()
				require("neotest").run.run(vim.fn.expand("%"))
			end, { desc = "Test File" })

			map("n", "<leader>ns", function()
				require("neotest").summary.toggle()
			end, { desc = "Toggle Test Summary" })
			
			map("n", "<leader>no", function()
				require("neotest").output.open({ enter = true })
			end, { desc = "Test Output" })
		end,
	},
}
