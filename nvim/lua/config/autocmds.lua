-- Autocmds
-- Add any global autocommands here

-- ==========================================
-- Fix treesitter folding (recompute folds after parser is ready)
-- ==========================================
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
	callback = function()
		-- Defer so treesitter has time to parse the full buffer
		vim.defer_fn(function()
			if vim.wo.foldmethod == "expr" then
				vim.cmd("normal! zx")
			end
		end, 100)
	end,
	desc = "Recompute treesitter folds after buffer is loaded",
})

-- ==========================================
-- XML Folding
-- ==========================================
vim.api.nvim_create_autocmd("FileType", {
    pattern = "xml",
    callback = function()
        -- Enable built-in XML syntax folding
        vim.g.xml_syntax_folding = 1
        -- Set fold method to syntax for XML files (tag-based folding)
        vim.opt_local.foldmethod = "syntax"
        -- Reset foldexpr since we're using syntax folding
        vim.opt_local.foldexpr = ""
        -- Apply syntax again to enable folding
        vim.cmd("syntax on")
        -- Start with all folds closed initially (you can open with zR)
        vim.cmd("normal zM")
    end,
    desc = "Enable tag-based folding for XML files",
})

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
