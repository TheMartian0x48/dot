return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    commit = "443f1ef",
    dependencies = {
        { "williamboman/mason.nvim", version = "v2.2.1" },
    },
    config = function()
        require("mason-tool-installer").setup {
            ensure_installed = {
                -- LSP servers are managed by mason-lspconfig

                -- Formatters
                "stylua",             -- Lua formatter
                "goimports",          -- Go formatter
                "prettier",           -- Web formatter
                "templ",              -- Templ formatter

                -- Debug adapters
                "delve",              -- Go debugger
                "debugpy",            -- Python debugger
                "js-debug-adapter",   -- JS/TS debugger
            },
            auto_update = true,
            run_on_start = true,
            start_delay = 3000, -- 3 second delay
        }
    end
}
