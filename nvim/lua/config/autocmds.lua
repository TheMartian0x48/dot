-- Autocmds
-- Add any global autocommands here

-- ==========================================
-- Go Templ Support
-- ==========================================

-- Register .templ filetype
vim.filetype.add({ extension = { templ = "templ" } })

-- Format .templ files on save using templ fmt
local templ_format = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local filename = vim.api.nvim_buf_get_name(bufnr)
	local cmd = "templ fmt " .. vim.fn.shellescape(filename)

	vim.fn.jobstart(cmd, {
		on_exit = function()
			-- Reload the buffer only if it's still the current buffer
			if vim.api.nvim_get_current_buf() == bufnr then
				vim.cmd('e!')
			end
		end,
	})
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.templ" },
	callback = templ_format,
	desc = "Format templ files on save",
})

-- Enable treesitter highlighting for .templ files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.templ",
	callback = function()
		vim.bo.filetype = "templ"
	end,
	desc = "Set filetype for templ files",
})

