-- Additional editor enhancement plugins
return {


    -- Highlight TODO comments
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("todo-comments").setup({
                signs = true,
                sign_priority = 8,
                keywords = {
                    FIX = {
                        icon = " ",
                        color = "error",
                        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                    },
                    TODO = { icon = " ", color = "info" },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
                },
                gui_style = {
                    fg = "NONE",
                    bg = "BOLD",
                },
                merge_keywords = true,
                highlight = {
                    multiline = true,
                    multiline_pattern = "^.",
                    multiline_context = 10,
                    before = "",
                    keyword = "wide",
                    after = "fg",
                    pattern = [[.*<(KEYWORDS)\\s*:]],
                    comments_only = true,
                    max_line_len = 400,
                    exclude = {},
                },
                colors = {
                    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                    info = { "DiagnosticInfo", "#2563EB" },
                    hint = { "DiagnosticHint", "#10B981" },
                    default = { "Identifier", "#7C3AED" },
                    test = { "Identifier", "#FF006E" },
                },
                search = {
                    command = "rg",
                    args = {
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                    },
                    pattern = [[\b(KEYWORDS):]],
                },
            })
        end,
    },

    -- Color highlighter
    {
        "norcalli/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("colorizer").setup({
                filetypes = { "*" },
                user_default_options = {
                    RGB = true,
                    RRGGBB = true,
                    names = true,
                    RRGGBBAA = false,
                    AARRGGBB = false,
                    rgb_fn = false,
                    hsl_fn = false,
                    css = false,
                    css_fn = false,
                    mode = "background",
                    tailwind = false,
                    sass = { enable = false, parsers = { "css" } },
                    virtualtext = "■",
                },
                buftypes = {},
            })
        end,
    },

    -- Zen mode for distraction-free writing
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        opts = {
            window = {
                backdrop = 0.95,
                width = 120,
                height = 1,
                options = {
                    signcolumn = "no",
                    number = false,
                    relativenumber = false,
                    cursorline = false,
                    cursorcolumn = false,
                    foldcolumn = "0",
                    list = false,
                },
            },
            plugins = {
                options = {
                    enabled = true,
                    ruler = false,
                    showcmd = false,
                    laststatus = 0,
                },
                twilight = { enabled = true },
                gitsigns = { enabled = false },
                tmux = { enabled = false },
                kitty = {
                    enabled = false,
                    font = "+4",
                },
                alacritty = {
                    enabled = false,
                    font = "14",
                },
                wezterm = {
                    enabled = false,
                    font = "+4",
                },
            },
        },
        keys = { { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
    },

    -- Dim inactive portions of code
    {
        "folke/twilight.nvim",
        opts = {
            dimming = {
                alpha = 0.25,
                color = { "Normal", "#ffffff" },
                term_bg = "#000000",
                inactive = false,
            },
            context = 10,
            treesitter = true,
            expand = {
                "function",
                "method",
                "table",
                "if_statement",
            },
            exclude = {},
        },
    },

    -- -- Split/join code blocks
    -- {
    --     "Wansmer/treesj",
    --     keys = {
    --         { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    --     },
    --     opts = { use_default_keymaps = false, max_join_length = 150 },
    -- },
}
