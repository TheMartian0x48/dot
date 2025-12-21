return {
	-- Flexoki
	{
		"kepano/flexoki-neovim",
		name = "flexoki",
		lazy = true,
		priority = 1000,
		-- Uncomment to use:
		-- config = function()
		-- 	vim.cmd([[colorscheme flexoki-dark]])
		-- end,
	},

	-- Nordic (Default)
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").setup({
				-- Use after_palette to override colors AFTER palette generation
				after_palette = function(palette)
					-- Override all background-related colors to pure black
					palette.black0 = "#000000"
					palette.black1 = "#000000"
					palette.black2 = "#000000"
					palette.gray0 = "#000000"
					palette.bg = "#000000"
					palette.bg_dark = "#000000"
					palette.bg_sidebar = "#000000"
					palette.bg_float = "#000000"
					palette.bg_popup = "#000000"
					-- Lighten gray colors for better readability on black background
					palette.gray4 = "#8899AA" -- Comments (was darker)
					palette.gray3 = "#99AABB" -- Lighter gray
					palette.gray2 = "#AABBCC" -- Even lighter
					palette.comment = "#8899AA" -- Ensure comments are lighter
					return palette
				end,
			})
			require("nordic").load()

			-- Override WinSeparator to remove background (thin line)
			vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#3B4252", bg = "NONE" })
		end,
	},

	-- Minimal
	{
		"yazeed1s/minimal.nvim",
		lazy = true,
		priority = 1000,
		-- Uncomment to use:
		-- config = function()
		-- end,
	},
}
