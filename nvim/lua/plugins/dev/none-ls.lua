-- none-ls configuration for enhanced formatting and linting
local none_ls = require("null-ls")

-- Go-specific formatters and tools
local go_sources = {
    -- Go formatting with goimports (handles imports + formatting)
    none_ls.builtins.formatting.goimports.with({
        extra_args = { "-local", "github.com" }, -- Adjust this to your project's module path
    }),

    -- Go line length management
    none_ls.builtins.formatting.golines.with({
        extra_args = { "--max-len=120", "--base-formatter=goimports" },
    }),

    -- Go doc comments - improves godoc formatting
    none_ls.builtins.formatting.godoc,

    -- Go struct tags management
    none_ls.builtins.formatting.gotests,

    -- Go test generation - automatically generate test stubs
    none_ls.builtins.code_actions.gomodifytags,

    -- Go error handling - implements error handling
    none_ls.builtins.code_actions.impl,

    -- Go test coverage - show test coverage info
    none_ls.builtins.diagnostics.staticcheck,
}

-- JavaScript/Web development sources
local web_sources = {
    -- JavaScript/JSON formatting (using prettier if available)
    none_ls.builtins.formatting.prettier.with({
        filetypes = { "javascript", "javascriptreact", "json", "jsonc", "html", "css" },
        extra_args = { "--single-quote", "--trailing-comma", "es5" },
    }),
}

-- General sources
local general_sources = {
    -- Lua formatting
    none_ls.builtins.formatting.stylua,

    -- Shell script formatting
    none_ls.builtins.formatting.shfmt.with({
        extra_args = { "-i", "2", "-ci" }, -- 2 spaces, indent switch cases
    }),
}

-- Combine all sources
local sources = {}
vim.list_extend(sources, go_sources)
vim.list_extend(sources, web_sources)
vim.list_extend(sources, general_sources)

none_ls.setup({
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
                            -- The plugin identifies itself as null-ls for compatibility
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
