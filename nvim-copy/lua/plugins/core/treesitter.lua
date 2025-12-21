-- Enhanced nvim-treesitter configuration with comprehensive language support
local config = {
    -- Comprehensive list of parsers for modern development
    ensure_installed = {
        -- Core languages
        "bash", "c", "cpp", "css", "html", "lua", "vim", "vimdoc",

        -- Web development
        "javascript", "json", "jsonc",
        "html", "css",

        -- Backend languages
        "python", "go", "gomod", "gowork", "gosum", "templ",
        "rust", "java", "elixir",

        -- Systems & DevOps
        "dockerfile", "yaml", "toml", "xml", "ini",
        "terraform", "hcl", "nginx",

        -- Documentation & Config
        "gitignore", "gitcommit", "gitattributes",

        -- Database & Query
        "sql", "query",

        -- Data & Config formats
        "csv", "tsv", "jq", "regex",

        -- Scripting
        "awk",

        -- Other useful parsers
        "comment", "diff", "git_rebase", "make",
    },

    -- Performance settings
    sync_install = false,
    auto_install = true,

    -- Enhanced highlighting with better performance
    highlight = {
        enable = true,
        -- Disable for large files to maintain performance
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },

    -- Smart indentation
    indent = {
        enable = true,
        -- Disable for problematic languages
        disable = { "python", "yaml" },
    },

    -- Enhanced incremental selection
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<S-CR>",
            node_decremental = "<BS>",
        },
    },

    -- Text objects for better navigation
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj
            keymaps = {
                -- Function textobjects
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                -- Class textobjects
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                -- Parameter/argument textobjects
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                -- Conditional textobjects
                ["ai"] = "@conditional.outer",
                ["ii"] = "@conditional.inner",
                -- Loop textobjects
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                -- Comment textobjects
                ["aC"] = "@comment.outer",
                ["iC"] = "@comment.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- Add to jumplist
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer",
                ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
                ["]C"] = "@class.outer",
                ["]A"] = "@parameter.inner",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer",
                ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[C"] = "@class.outer",
                ["[A"] = "@parameter.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
                ["<leader>nf"] = "@function.outer",  -- swap function with next
            },
            swap_previous = {
                ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
                ["<leader>pf"] = "@function.outer",  -- swap function with previous
            },
        },
    },

    -- Enhanced folding
    fold = {
        enable = true, -- Enable treesitter folding
        disable = {},  -- Remove any disabled languages
    },

    -- Rainbow parentheses (requires nvim-ts-rainbow or similar plugin)
    -- rainbow = {
    --     enable = true,
    --     extended_mode = true,
    --     max_file_lines = nil,
    --     colors = {
    --         "#cc241d", -- Red
    --         "#a89984", -- Gray
    --         "#b16286", -- Purple
    --         "#d79921", -- Yellow
    --         "#689d6a", -- Aqua
    --         "#d65d0e", -- Orange
    --         "#458588", -- Blue
    --     },
    -- },

    -- Autopairs integration (requires nvim-autopairs plugin)
    -- autopairs = {
    --     enable = true,
    -- },

    -- Context-aware commenting (requires Comment.nvim or similar)
    -- context_commentstring = {
    --     enable = true,
    --     enable_autocmd = false, -- Let other plugins handle this
    -- },

    -- Playground for treesitter (requires nvim-treesitter-playground)
    -- playground = {
    --     enable = true,
    --     disable = {},
    --     updatetime = 25,
    --     persist_queries = false,
    --     keybindings = {
    --         toggle_query_editor = 'o',
    --         toggle_hl_groups = 'i',
    --         toggle_injected_languages = 't',
    --         toggle_anonymous_nodes = 'a',
    --         toggle_language_display = 'I',
    --         focus_language = 'f',
    --         unfocus_language = 'F',
    --         update = 'R',
    --         goto_node = '<cr>',
    --         show_help = '?',
    --     },
    -- },
}

require('nvim-treesitter.configs').setup(config)
