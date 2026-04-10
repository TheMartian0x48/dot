return {
	"kylechui/nvim-surround",
	version = "v4.0.3",
	event = "VeryLazy",
	opts = {
		-- Default keymaps:
		-- ys{motion}{char} - Add surround
		-- ds{char} - Delete surround
		-- cs{target}{replacement} - Change surround
		-- Examples:
		--   ysiw" - Surround word with "
		--   cs"' - Change " to '
		--   ds" - Delete "
		--   ySS) - Surround line with ()
	},
}
