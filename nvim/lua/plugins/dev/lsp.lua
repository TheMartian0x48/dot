-- Enhanced LSP Configuration with comprehensive language support
require("mason").setup({
    ui = {
        border = "rounded",
        winblend = 0, -- No transparency (opaque)
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    ensure_installed = {
        -- Core languages
        "lua_ls",
        "html",
        "cssls",
        "clangd", -- cpp, c
        "elixirls",
        "gopls",
        "jsonls",
        "rust_analyzer",
        "templ",
        "jdtls",

        -- Additional popular servers
        "pyright",  -- Python
        "ts_ls",    -- JavaScript only (no TypeScript)
        "bashls",   -- Bash
        "yamlls",   -- YAML
        "dockerls", -- Docker
    },
    automatic_installation = true,
})

-- Ensure Go development tools are installed
local mason_registry = require("mason-registry")
local go_tools = {
    "goimports",
    -- "gofmt",
    "golines",
    "golangci-lint",
}

for _, tool in ipairs(go_tools) do
    local p = mason_registry.get_package(tool)
    if not p:is_installed() then
        p:install()
    end
end

local elixir_ls_path = vim.fn.expand("~/.local/share/elixir-ls")
local elixir_cmd = { elixir_ls_path .. "/language_server.sh" }

-- Enhanced border configuration
local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}

-- Configure LSP UI
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    opts.winblend = 0 -- No transparency (opaque)
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Enhanced diagnostic configuration
vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
            [vim.diagnostic.severity.INFO] = " ",
        },
        linehl = {},
        numhl = {},
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = border,
        source = "always",
        header = "",
        prefix = "",
        winblend = 0, -- No transparency (opaque)
    },
})

-- Modern diagnostic configuration is handled above in vim.diagnostic.config()
-- No need for manual sign definitions anymore

-- Enhanced on_attach function with comprehensive keymaps
local on_attach = function(client, bufnr)
    -- Helper function for buffer-local keymaps
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    -- Navigation
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
    map("n", "gr", vim.lsp.buf.references, "Show references")

    -- Information
    map("n", "K", vim.lsp.buf.hover, "Show hover")
    map("n", "gs", vim.lsp.buf.signature_help, "Show signature help")
    map("i", "<C-h>", vim.lsp.buf.signature_help, "Show signature help (insert)")

    -- Diagnostics navigation
    map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")



    -- Highlight symbol under cursor
    if client.server_capabilities.documentHighlightProvider then
        local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    -- Enable inlay hints if supported
    if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        map("n", "<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end, "Toggle inlay hints")
    end
end

-- Enhanced capabilities with additional features
local lsp_config = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Add snippet support
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" }
}

-- Add folding capabilities
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- Auto-format on save with better error handling
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        -- Format on save for specific filetypes (JavaScript only, no TypeScript)
        local format_on_save_filetypes = {
            -- Core languages
            "bash", "sh", "c", "cpp", "css", "html", "lua", "vim",

            -- Web development (JavaScript only, no TypeScript)
            "javascript", "javascriptreact", "json", "jsonc",

            -- Backend languages
            "python", "go", "rust", "java", "elixir",

            -- Systems & DevOps
            "dockerfile", "yaml", "yml", "toml", "xml", "ini",
            "terraform", "hcl",

            -- Database & Query
            "sql",

            -- Data & Config formats
            "csv", "tsv",

            -- Other useful formats
            "make", "makefile",
        }

        if client:supports_method('textDocument/formatting') and
            vim.tbl_contains(format_on_save_filetypes, vim.bo[args.buf].filetype) then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                    local params = vim.lsp.util.make_formatting_params({})
                    client:request('textDocument/formatting', params, nil, args.buf)
                end,
            })
        end
    end
})

-- LSP Server Configurations
-- Lua
lsp_config.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
            hint = { enable = true },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                }
            }
        },
    },
})
-- jdtls is configured separately in java.lua
-- lsp_config.jdtls.setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
-- })
-- HTML with enhanced capabilities
lsp_config.html.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "html", "templ" },
})

-- CSS with additional features
lsp_config.cssls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        css = {
            validate = true,
            lint = {
                unknownAtRules = "ignore"
            }
        },
        scss = {
            validate = true,
            lint = {
                unknownAtRules = "ignore"
            }
        }
    }
})

-- C/C++
lsp_config.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },
})

-- Enhanced Go configuration with debugging and better error handling
local util = require("lspconfig.util")

lsp_config.gopls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Enable inlay hints for Go if supported
        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        on_attach(client, bufnr)
    end,

    -- Ensure correct command and path
    cmd = { "gopls" }, 

    -- Explicit filetypes
    filetypes = { "go", "gomod", "gowork", "gotmpl" },


    -- Enhanced settings
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
                unreachable = true,
                nilness = true,
                unusedwrite = true,
            },
            staticcheck = true,
            usePlaceholders = true,
            completeUnimported = true,
            completionDocumentation = true,
            deepCompletion = true,
            matcher = "fuzzy",

            -- Code lenses
            codelenses = {
                gc_details = true,
                generate = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },

            -- Inlay hints
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },

            -- Workspace settings
            buildFlags = { "-tags", "integration" },
            env = {
                GOFLAGS = "-tags=integration",
            },

            -- Experimental features (removed deprecated ones)
            experimentalPostfixCompletions = true,
        },
    },

    -- Additional flags for better compatibility
    flags = {
        debounce_text_changes = 150,
    },
})

-- Rust with enhanced settings
lsp_config.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true,
            },
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
            },
            procMacro = {
                enable = true,
                ignored = {
                    leptos_macro = {
                        "component",
                        "server",
                    },
                },
            },
            inlayHints = {
                bindingModeHints = {
                    enable = false,
                },
                chainingHints = {
                    enable = true,
                },
                closingBraceHints = {
                    enable = true,
                    minLines = 25,
                },
                closureReturnTypeHints = {
                    enable = "never",
                },
                lifetimeElisionHints = {
                    enable = "never",
                    useParameterNames = false,
                },
                maxLength = 25,
                parameterHints = {
                    enable = true,
                },
                reborrowHints = {
                    enable = "never",
                },
                renderColons = true,
                typeHints = {
                    enable = true,
                    hideClosureInitialization = false,
                    hideNamedConstructor = false,
                },
            },
        }
    }
})

-- JSON with basic configuration
lsp_config.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Remaining existing servers
lsp_config.elixirls.setup({
    cmd = elixir_cmd,
    capabilities = capabilities,
    on_attach = on_attach,
})


lsp_config.templ.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Python
lsp_config.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
            },
        },
    },
})

-- JavaScript (TypeScript support removed)
lsp_config.ts_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "javascript", "javascriptreact" }, -- Only JS files, no TS
    settings = {
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
    },
})

-- Bash
lsp_config.bashls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- YAML
lsp_config.yamlls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://json.schemastore.org/github-action.json"] = "/.github/action.{yml,yaml}",
                ["https://json.schemastore.org/composer.json"] = "/composer.{yml,yaml}",
                ["https://json.schemastore.org/kustomization.json"] = "/kustomization.{yml,yaml}",
                ["https://json.schemastore.org/chart.json"] = "/Chart.{yml,yaml}",
            },
        },
    },
})

-- Docker
lsp_config.dockerls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})


-- Export functions for use by other plugins
return {
    on_attach = on_attach,
    capabilities = capabilities,
}
