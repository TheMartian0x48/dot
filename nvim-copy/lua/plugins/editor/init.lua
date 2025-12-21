-- Editor enhancement plugins
return {
    -- Auto completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- Core completion sources
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",

            -- Snippet integration
            "saadparwaiz1/cmp_luasnip",

            -- Additional useful sources
            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
                config = function()
                    -- Load VSCode-style snippets
                    require("luasnip.loaders.from_vscode").lazy_load()

                    -- Load custom snippets
                    require("luasnip.loaders.from_vscode").lazy_load({
                        paths = { vim.fn.stdpath("config") .. "/snippets" }
                    })

                    -- Configure LuaSnip
                    local luasnip = require("luasnip")
                    luasnip.config.setup({
                        history = true,
                        updateevents = "TextChanged,TextChangedI",
                        delete_check_events = "TextChanged",
                        region_check_events = "CursorMoved",
                    })
                end,
            },
        },
        config = function()
            require("plugins.editor.autocomplete")
        end,
    },

    -- Surround operations
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    -- Mini.ai for better text objects
    {
        "echasnovski/mini.ai",
        config = function()
            require("plugins.editor.miniai")
        end,
    },

    -- Trouble for diagnostics
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        config = function()
            require("plugins.editor.trouble")
        end,
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    -- Auto pairs for brackets, quotes, etc.
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
                ts_config = {
                    lua = { "string", "source" },
                    javascript = { "string", "template_string" },
                    java = false,
                },
                disable_filetype = { "TelescopePrompt", "spectre_panel" },
                fast_wrap = {
                    map = "<M-e>",
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                    offset = 0,
                    end_key = "$",
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    check_comma = true,
                    highlight = "PmenuSel",
                    highlight_grey = "LineNr"
                },
            })
        end,
    },

    -- Markdown rendering
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("render-markdown").setup({
                heading = {
                    position = 'inline',
                    icons = { ' > ', ' >> ', ' >>> ', ' >>>> ', ' >>>>> ', ' >>>>>> ' }
                },

            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
}
