-- nvim-treesitter-context configuration
-- Shows context of current buffer contents at the top when scrolling

require('treesitter-context').setup({
    -- Enable the plugin
    enable = true,

    -- Maximum number of lines to show for context
    max_lines = 4,

    -- Minimum window height to show context (avoid showing on small splits)
    min_window_height = 10,

    -- Line numbers in context area
    line_numbers = true,

    -- Multiline threshold - show context when cursor is this many lines from top
    multiline_threshold = 20,

    -- Trim whitespace at beginning and end of context lines
    trim_scope = 'outer',

    -- Which context to show (can be 'cursor' or 'topline')
    mode = 'cursor',

    -- Separator between context and buffer content
    separator = nil, -- Use default separator

    -- Z-index of the context window
    zindex = 20,

    -- Patterns to match for showing context
    -- These are treesitter node types that should trigger context display
    patterns = {
        -- Default patterns for most languages
        default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
            'interface',
            'struct',
            'enum',
        },

        -- Language-specific patterns
        rust = {
            'impl_item',
            'struct',
            'enum',
            'function_item',
            'mod_item',
            'trait_item',
            'match_expression',
        },

        python = {
            'function_definition',
            'class_definition',
            'for_statement',
            'while_statement',
            'if_statement',
            'with_statement',
            'try_statement',
        },

        javascript = {
            'function_declaration',
            'function_expression',
            'arrow_function',
            'method_definition',
            'class_declaration',
            'for_statement',
            'while_statement',
            'if_statement',
            'switch_statement',
        },

        typescript = {
            'function_declaration',
            'function_expression',
            'arrow_function',
            'method_definition',
            'class_declaration',
            'interface_declaration',
            'type_alias_declaration',
            'for_statement',
            'while_statement',
            'if_statement',
            'switch_statement',
        },

        go = {
            'function_declaration',
            'method_declaration',
            'type_declaration',
            'struct_type',
            'interface_type',
            'for_statement',
            'if_statement',
            'switch_statement',
        },

        lua = {
            'function_declaration',
            'function_definition',
            'local_function',
            'function_call',
            'table_constructor',
            'for_statement',
            'while_statement',
            'if_statement',
        },

        c = {
            'function_definition',
            'struct_specifier',
            'enum_specifier',
            'union_specifier',
            'for_statement',
            'while_statement',
            'if_statement',
            'switch_statement',
        },

        cpp = {
            'function_definition',
            'class_specifier',
            'struct_specifier',
            'enum_specifier',
            'namespace_definition',
            'for_statement',
            'while_statement',
            'if_statement',
            'switch_statement',
        },

        java = {
            'method_declaration',
            'class_declaration',
            'interface_declaration',
            'enum_declaration',
            'for_statement',
            'while_statement',
            'if_statement',
            'switch_expression',
        },
    },
})

-- Set up keybindings for treesitter-context
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Jump to context line
keymap('n', '[c', function()
    require('treesitter-context').go_to_context(vim.v.count1)
end, vim.tbl_extend('force', opts, { desc = 'Jump to context' }))

-- Toggle treesitter-context
keymap('n', '<leader>tc', '<cmd>TSContextToggle<cr>',
    vim.tbl_extend('force', opts, { desc = 'Toggle Treesitter Context' }))

-- Set up highlight groups for better visibility
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
        -- Context background - slightly different from normal background
        vim.api.nvim_set_hl(0, 'TreesitterContext', {
            bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Normal')), 'bg#') or 'NONE',
            fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Normal')), 'fg#') or 'NONE',
        })

        -- Context line numbers
        vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', {
            fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('LineNr')), 'fg#') or 'NONE',
            bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('TreesitterContext')), 'bg#') or 'NONE',
        })

        -- Context separator (bottom border)
        vim.api.nvim_set_hl(0, 'TreesitterContextBottom', {
            underline = true,
            sp = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Comment')), 'fg#') or 'NONE',
        })
    end,
})

-- Trigger the highlight setup for current colorscheme
vim.cmd('doautocmd ColorScheme')
