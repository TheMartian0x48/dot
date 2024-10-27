require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "gradle_ls",
        "jdtls",
        "cssls",
        "html",
        "eslint",
    },
})

local lsp_config = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
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

lsp_config.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp_config.gradle_ls.setup({
    filetypes = { "groovy", "kotlin" },
    root_dir = lsp_config.util.root_pattern(
        "settings.gradle",
        "build.gradle",
        "settings.gradle.kts",
        "build.gradle.kts"
    ),
    capabilities = capabilities,
    on_attach = on_attach,
})

lsp_config.jdtls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lsp_config.cssls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp_config.html.setup({
    filetypes = { "html", "templ", "ftlh" },
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp_config.eslint.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
