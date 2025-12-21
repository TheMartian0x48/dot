return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- 1. Setup Mason
			require("mason").setup()

			-- 2. Setup Mason LSPConfig
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"templ",
					"html",
					"htmx",
					"cssls",
					"ts_ls",
					"zls",
					"lua_ls",
				},
				automatic_installation = true,
			})

			-- 3. Setup LSP using modern vim.lsp.config API (Neovim 0.11+)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Configure each server using vim.lsp.config
			vim.lsp.config.gopls = {
				capabilities = capabilities,
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
			}

			vim.lsp.config.templ = {
				capabilities = capabilities,
			}

			vim.lsp.config.html = {
		capabilities = capabilities,
		filetypes = { "html", "templ" },
	}

	vim.lsp.config.htmx = {
		capabilities = capabilities,
		filetypes = { "html", "templ" },
	}

	vim.lsp.config.cssls = {
		capabilities = capabilities,
	}

	vim.lsp.config.ts_ls = {
		capabilities = capabilities,
	}

	vim.lsp.config.zls = {
		capabilities = capabilities,
	}

	vim.lsp.config.lua_ls = {
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
			},
		},
	}

	-- Enable all configured servers
	vim.lsp.enable({ "gopls", "templ", "html", "htmx", "cssls", "ts_ls", "zls", "lua_ls" })
		end,
	}
}
