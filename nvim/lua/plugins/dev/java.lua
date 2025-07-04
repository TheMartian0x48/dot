-- Java LSP Configuration using jdtls
-- Self-contained to avoid circular dependencies

-- Define on_attach function for Java LSP
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

-- Define capabilities for Java LSP
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Check if cmp_nvim_lsp is available and enhance capabilities
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

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

-- Configure jdtls (Eclipse JDT Language Server)
require("lspconfig").jdtls.setup({
    capabilities = capabilities,
    on_attach = on_attach,

    -- jdtls specific settings
    settings = {
        java = {
            -- Code generation settings
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                useBlocks = true,
            },

            -- Completion settings
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                },

                importOrder = {
                    "java",
                    "javax",
                    "deshaw",
                    "com",
                    "org",
                },

                -- Improve completion behavior
                guessMethodArguments = true,
                lazyResolveTextEdit = true,
                matchCase = "firstLetter",

                -- Filter out unwanted suggestions
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
            },

            -- Diagnostics
            eclipse = {
                downloadSources = true,
            },

            -- Maven settings
            maven = {
                downloadSources = true,
            },

            -- Implementation code lens
            implementationsCodeLens = {
                enabled = true,
            },

            -- Reference code lens
            referencesCodeLens = {
                enabled = true,
            },

            -- Inlay hints
            inlayHints = {
                parameterNames = {
                    enabled = "all" -- literals, all, none
                }
            },

            -- Format settings
            -- format = {
            --     enabled = true,
            --     settings = {
            --         url = vim.fn.stdpath("config") .. "/lang-servers/java/eclipse-java-style-formatter.xml",
            --         profile = "any profile name",
            --     },
            -- },

            -- Template settings
            -- templates = {
            --     fileHeader = {},
            --     typeComment = {},
            --     codeSnippets = {},
            --     url = vim.fn.stdpath("config") .. "/lang-servers/java/eclipse-java-style-template.xml",
            -- },
        },

        -- Signature help
        signatureHelp = {
            enabled = true,
        },

        -- Content provider
        contentProvider = {
            preferred = "fernflower",
        },

        -- Extractor
        extractor = {
            enabled = true,
        },

        -- Sources
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
    },

    -- Initialization options
    init_options = {
        bundles = {
            vim.fn.expand("~/.config/nvim/lang-servers/java/lombok.jar")
        }
    },

    cmd = {
        vim.fn.expand("~/.config/nvim/lang-servers/java/jdtls-lombok.sh"),
    },

    -- Root directory detection
    root_dir = function(fname)
        local util = require("lspconfig.util")
        return util.root_pattern(
        -- Single-module projects
            {
                "build.xml",           -- Ant
                "pom.xml",             -- Maven
                "settings.gradle",     -- Gradle
                "settings.gradle.kts", -- Gradle
            },
            -- Multi-module projects
            { "build.gradle", "build.gradle.kts" }
        )(fname) or util.find_git_ancestor(fname)
    end,
})
