return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"vrischmann/tree-sitter-templ",
		},
		build = ":TSUpdate",
		config = function()
			local status, configs = pcall(require, "nvim-treesitter.configs")
            if not status then
                return
            end

			configs.setup({
				ensure_installed = { 
                    "c", "lua", "vim", "vimdoc", "query", 
                    "go", "templ", "html", "css", "javascript", "typescript", "zig" 
                },
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
			})
		end,
	}
}
