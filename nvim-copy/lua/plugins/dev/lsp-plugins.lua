-- LSP servers and formatting plugins
return {
    -- LSP servers
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("plugins.dev.lsp")
            require("plugins.dev.java")
        end,
    },
}
