return {
	-- Flexoki
	{
		"kepano/flexoki-neovim",
		commit = "c3e2251",
		name = "flexoki",
		lazy = true,
		priority = 1000,
		-- Uncomment to use:
		-- config = function()
		-- 	vim.cmd([[colorscheme flexoki-dark]])
		-- end,
	},

	{
		"metalelf0/black-metal-theme-neovim",
		lazy = false,
		priority = 1000,
		config = function()
			require("black-metal").setup({
				theme = "khold",
				variant = "dark",
				colored_docstrings = true,
			})
			require("black-metal").load()
		end,
	},

	-- Gruvbox Material
	{
		"sainnhe/gruvbox-material",
		commit = "790afe9",
		lazy = false,
		priority = 1000,
		-- config = function()
		-- 	-- Settings must be set BEFORE loading the colorscheme
		-- 	vim.g.gruvbox_material_background = "hard"
		-- 	vim.g.gruvbox_material_foreground = "mix" -- Softer contrast
		-- 	vim.g.gruvbox_material_enable_italic = 1
		-- 	vim.g.gruvbox_material_better_performance = 1
		--
		-- 	vim.cmd([[colorscheme gruvbox-material]])
		--
		-- 	-- Overrides for pure black background
		-- 	local colors = {
		-- 		bg = "#000000",
		-- 	}
		--
		-- 	-- Groups to set to pure black background
		-- 	local bg_groups = {
		-- 		"Normal",
		-- 		"NormalNC",
		-- 		"SignColumn",
		-- 		"NormalFloat",
		-- 		"FloatBorder",
		-- 		"Pmenu",
		-- 		"PmenuSbar",
		-- 		"PmenuThumb",
		-- 		"TabLine",
		-- 		"TabLineFill",
		-- 		"StatusLine",
		-- 		"StatusLineNC",
		-- 		"WinBar",
		-- 		"WinBarNC",
		-- 		"Terminal",
		-- 		"EndOfBuffer",
		-- 	}
		--
		-- 	for _, group in ipairs(bg_groups) do
		-- 		vim.api.nvim_set_hl(0, group, { bg = colors.bg })
		-- 	end
		--
		-- 	-- Link other groups
		-- 	vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
		-- end,
	},

	-- Nordic
	{
		"AlexvZyl/nordic.nvim",
		commit = "4ce6bad",
		lazy = true,
		priority = 1000,
		-- Uncomment to use:
		-- config = function()
		-- 	require("nordic").setup({
		-- 		-- Use after_palette to override colors AFTER palette generation
		-- 		after_palette = function(palette)
		-- 			-- Override all background-related colors to pure black
		-- 			palette.black0 = "#000000"
		-- 			palette.black1 = "#000000"
		-- 			palette.black2 = "#000000"
		-- 			palette.gray0 = "#000000"
		-- 			palette.bg = "#000000"
		-- 			palette.bg_dark = "#000000"
		-- 			palette.bg_sidebar = "#000000"
		-- 			palette.bg_float = "#000000"
		-- 			palette.bg_popup = "#000000"
		-- 			-- Lighten gray colors for better readability on black background
		-- 			palette.gray4 = "#8899AA" -- Comments (was darker)
		-- 			palette.gray3 = "#99AABB" -- Lighter gray
		-- 			palette.gray2 = "#AABBCC" -- Even lighter
		-- 			palette.comment = "#8899AA" -- Ensure comments are lighter
		-- 			return palette
		-- 		end,
		-- 	})
		-- 	require("nordic").load()
		-- 	-- Override WinSeparator to remove background (thin line)
		-- 	vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#3B4252", bg = "NONE" })
		-- end,
	},
}
