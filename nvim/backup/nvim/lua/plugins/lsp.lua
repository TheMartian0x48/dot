require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"html",
		"cssls",
		"ts_ls",
		"pylsp",
		"clangd", -- cpp, c
		"elixirls",
		"gopls",
		"golangci_lint_ls",
		"jdtls",
		"jsonls",
		"zls",
		"phpactor"
	}
})

local border = {
	{ "🭽", "FloatBorder" },
	{ "▔", "FloatBorder" },
	{ "🭾", "FloatBorder" },
	{ "▕", "FloatBorder" },
	{ "🭿", "FloatBorder" },
	{ "▁", "FloatBorder" },
	{ "🭼", "FloatBorder" },
	{ "▏", "FloatBorder" },
}

local on_attach = function(_, _)
	vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", {})
	vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
	vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", {})
	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", {})
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", {})
	vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", {})
	vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {})
	vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", {})
	vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", {})
	vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", {})
end

local lsp_config = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then return end
		if client.supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer   = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
				end,
			})
		end
	end
})

lsp_config.lua_ls.setup {
	capabilities = capabilities,
	on_attach = on_attach,
}


lsp_config.html.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp_config.cssls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp_config.ts_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})


lsp_config.clangd.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp_config.elixirls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp_config.pylsp.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp_config.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})


lsp_config.golangci_lint_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp_config.jdtls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp_config.jsonls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp_config.zls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lsp_config.phpactor.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
