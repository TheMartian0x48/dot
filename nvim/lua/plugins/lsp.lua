return {
    {
        "neovim/nvim-lspconfig",
        version = "v2.6.0",
        dependencies = {
            { "williamboman/mason.nvim", version = "v2.2.1" },
            { "williamboman/mason-lspconfig.nvim", version = "v2.1.0" },
            { "hrsh7th/cmp-nvim-lsp", commit = "cbc7b02" },
        },
        config = function()
            -- 1. Setup Mason
            require("mason").setup()

            -- 2. Setup Mason LSPConfig
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "gopls",
                    "html",
                    "cssls",
                    "lua_ls",
                    "ts_ls",
                    "pyright",
                    "templ",
                },
                automatic_installation = true,
            })

            -- 3. Setup LSP using modern vim.lsp.config API (Neovim 0.11+)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Go
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

            -- TypeScript/JavaScript
            vim.lsp.config.ts_ls = {
                capabilities = capabilities,
                filetypes = { "javascript", "typescript" },
            }

            -- Python
            vim.lsp.config.pyright = {
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                        },
                    },
                },
            }

            -- HTML
            vim.lsp.config.html = {
                capabilities = capabilities,
                filetypes = { "html" },
            }

            -- CSS
            vim.lsp.config.cssls = {
                capabilities = capabilities,
            }

            -- Lua
            vim.lsp.config.lua_ls = {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            }

            -- Templ
            vim.lsp.config.templ = {
                capabilities = capabilities,
            }

            -- Enable all configured servers
            vim.lsp.enable({ "gopls", "ts_ls", "pyright", "html", "cssls", "lua_ls", "templ" })
        end,
    }
}
