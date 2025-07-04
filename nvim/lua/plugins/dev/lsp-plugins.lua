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

    -- Formatting and linting with none-ls
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
            "nvim-lua/plenary.nvim", -- Required dependency
        },
        config = function()
            require("plugins.dev.none-ls")
        end,
    },
}
