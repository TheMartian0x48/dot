-- Autocmds
-- Add any global autocommands here

-- ==========================================
-- Go Templ Support
-- ==========================================

-- Register .templ filetype
vim.filetype.add({ extension = { templ = "templ" } })



-- Enable treesitter highlighting for .templ files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.templ",
	callback = function()
		vim.bo.filetype = "templ"
	end,
	desc = "Set filetype for templ files",
})
