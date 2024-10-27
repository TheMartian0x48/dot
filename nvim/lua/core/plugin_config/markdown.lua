local peek = require("peek")
peek.setup({
	app = "Brave Browser",
	theme = "light",
})
vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
vim.api.nvim_create_user_command("PeekClose", peek.close, {})
-- require("markview").setup({})
