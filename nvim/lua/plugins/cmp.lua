return {
	{
		"hrsh7th/nvim-cmp",
		version = "v0.0.2",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", commit = "cbc7b02" },
			{ "hrsh7th/cmp-buffer", commit = "b74fab3" },
			{ "hrsh7th/cmp-path", commit = "c642487" },
			{ "hrsh7th/cmp-cmdline", commit = "d126061" },
			{
				"L3MON4D3/LuaSnip",
				version = "v2.4.1",
				dependencies = { { "rafamadriz/friendly-snippets", commit = "6cd7280" } },
				build = "make install_jsregexp",
			},
			{ "saadparwaiz1/cmp_luasnip", commit = "98d9cb5" },
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Load friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					
					-- Tab: Completion navigation OR snippet expansion
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					
					-- Dedicated snippet jump keys (no conflict with completion)
					["<C-j>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					
					["<C-k>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
                    { name = "path" },
				}),
			})
		end,
	}
}
