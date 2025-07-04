-- ============================================================================
-- NVIM-CMP AUTOCOMPLETE CONFIGURATION
-- Enhanced setup with performance optimizations and comprehensive sources
-- ============================================================================

local cmp = require("cmp")
local luasnip = require("luasnip")

    -- Enhanced completion setup
cmp.setup({
    completion = {
        completeopt = "menu,menuone,noselect", -- Better UX with noselect
        keyword_length = 1,
        keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    },

    -- Sorting and deduplication
    sorting = {
        priority_weight = 2,
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },

    -- Duplicate handling
    duplicates = {
        nvim_lsp = 1,
        luasnip = 1,
        buffer = 1,
        path = 1,
        nvim_lua = 1,
    },

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    window = {
        completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpDoc",
        }),
    },

    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            local kind_icons = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "",
            }
            
            -- Source names with different colors/styles
            local source_names = {
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
                buffer = "[Buf]",
                path = "[Path]",
                nvim_lua = "[API]",
                cmdline = "[Cmd]",
            }
            
            -- Add icon with kind
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or "", vim_item.kind)
            
            -- Add source identifier
            vim_item.menu = source_names[entry.source.name] or "[?]"
            
            -- Truncate long completion items
            if string.len(vim_item.abbr) > 50 then
                vim_item.abbr = string.sub(vim_item.abbr, 1, 47) .. "..."
            end
            
            -- Add duplicate identifier if needed (for debugging)
            if entry.source.name == "buffer" and entry.source.source and entry.source.source.keyword then
                vim_item.dup = 0 -- Prevent buffer duplicates
            end
            
            return vim_item
        end,
    },

    mapping = cmp.mapping.preset.insert({
        -- Core navigation
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        
        -- Documentation scrolling
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        
        -- Completion control
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        
        -- Confirm completion
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false, -- Only confirm explicitly selected items
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),

    sources = cmp.config.sources({
        -- Primary sources (higher priority) - these will be shown first
        { 
            name = "nvim_lsp",
            priority = 1000,
            keyword_length = 1,
            max_item_count = 20,
            group_index = 1,
        },
        { 
            name = "luasnip",
            priority = 750,
            keyword_length = 1,
            max_item_count = 15,
            group_index = 1,
        },
        { 
            name = "nvim_lua",
            priority = 700,
            keyword_length = 1,
            max_item_count = 10,
            group_index = 1,
        },
    }, {
        -- Secondary sources (fallback) - only shown if primary sources don't provide enough
        { 
            name = "buffer",
            priority = 500,
            keyword_length = 3,
            max_item_count = 5,
            group_index = 2,
            option = {
                get_bufnrs = function()
                    -- Only complete from current buffer to reduce duplicates
                    return { vim.api.nvim_get_current_buf() }
                end
            }
        },
        { 
            name = "path",
            priority = 300,
            keyword_length = 1,
            max_item_count = 5,
            group_index = 2,
        },
    }),

    -- Performance settings
    performance = {
        debounce = 60,
        throttle = 30,
        fetching_timeout = 500,
        confirm_resolve_timeout = 80,
        async_budget = 1,
        max_view_entries = 50, -- Reduced to prevent too many duplicates
    },

    -- Preselect behavior
    preselect = cmp.PreselectMode.None,

    -- View configuration
    view = {
        entries = { name = "custom", selection_order = "near_cursor" }
    },

    -- Experimental features
    experimental = {
        ghost_text = {
            hl_group = "CmpGhostText",
        },
    },
})

-- ============================================================================
-- CMDLINE COMPLETION SETUP
-- Enhanced command-line completion for search and commands
-- ============================================================================

-- Search completion (/, ?)
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline({
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "c" }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "c" }),
    }),
    sources = cmp.config.sources({
        { name = "buffer" }
    }),
    completion = {
        completeopt = "menu,menuone,noselect",
    },
})

-- Command completion (:)
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline({
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "c" }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "c" }),
    }),
    sources = cmp.config.sources({
        { 
            name = "path",
            option = {
                trailing_slash = true,
            }
        }
    }, {
        { 
            name = "cmdline",
            option = {
                ignore_cmds = { "Man", "!" }
            }
        }
    }),
    completion = {
        completeopt = "menu,menuone,noselect",
    },
    matching = { 
        disallow_symbol_nonprefix_matching = false,
        disallow_fuzzy_matching = false,
    },
})

-- ============================================================================
-- ADDITIONAL CONFIGURATION
-- ============================================================================

-- Custom deduplication function
local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Set up nice highlighting for completion menu
vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

-- Disable completion in certain contexts  
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        require("cmp").setup.buffer({ 
            enabled = false 
        })
    end,
})

-- Configure completion for specific filetypes to reduce duplicates
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua" },
    callback = function()
        require("cmp").setup.buffer({
            sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000, max_item_count = 20 },
                { name = "nvim_lua", priority = 900, max_item_count = 15 },
                { name = "luasnip", priority = 800, max_item_count = 10 },
            }, {
                { name = "buffer", keyword_length = 4, max_item_count = 3 },
                { name = "path", max_item_count = 3 },
            })
        })
    end,
})

-- Auto-pairs integration (if available)
local ok, autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if ok then
    cmp.event:on("confirm_done", autopairs.on_confirm_done())
end

-- LuaSnip keymaps have been moved to lua/keymaps.lua for centralized management
