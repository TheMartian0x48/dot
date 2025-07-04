-- none-ls configuration for enhanced formatting and linting
local null_ls = require("null-ls")

-- Go-specific formatters and tools
local go_sources = {
    -- Go formatting with goimports (handles imports + formatting)
    null_ls.builtins.formatting.goimports.with({
        extra_args = { "-local", "github.com" }, -- Adjust this to your project's module path
    }),

    -- Go line length management
    null_ls.builtins.formatting.golines.with({
        extra_args = { "--max-len=120", "--base-formatter=goimports" },
    }),

    -- Additional Go linting (golangci-lint is already handled by LSP)
    null_ls.builtins.diagnostics.golangci_lint.with({
        extra_args = { "--fast" },
    }),
}

-- JavaScript/Web development sources
local web_sources = {
    -- JavaScript/JSON formatting (using prettier if available)
    null_ls.builtins.formatting.prettier.with({
        filetypes = { "javascript", "javascriptreact", "json", "jsonc", "html", "css" },
        extra_args = { "--single-quote", "--trailing-comma", "es5" },
    }),
}

-- General sources
local general_sources = {
    -- Lua formatting
    null_ls.builtins.formatting.stylua,

    -- Shell script formatting
    null_ls.builtins.formatting.shfmt.with({
        extra_args = { "-i", "2", "-ci" }, -- 2 spaces, indent switch cases
    }),

    -- Markdown formatting
    null_ls.builtins.formatting.markdownlint,
}

-- Combine all sources
local sources = {}
vim.list_extend(sources, go_sources)
vim.list_extend(sources, web_sources)
vim.list_extend(sources, general_sources)

null_ls.setup({
    sources = sources,

    -- Enhanced formatting on save
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        filter = function(formatting_client)
                            -- Prefer none-ls for Go files
                            if vim.bo[bufnr].filetype == "go" then
                                return formatting_client.name == "null-ls"
                            end
                            return true
                        end,
                    })
                end,
            })
        end
    end,

    -- Debug mode (set to true if you need to troubleshoot)
    debug = false,

    -- Border for floating windows
    border = "rounded",
})

return {}
