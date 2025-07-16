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
    
    -- GitHub Copilot
    {
        "github/copilot.vim",
        event = "InsertEnter",
        config = function()
            -- Enable Copilot for specific filetypes
            vim.g.copilot_filetypes = {
                ["*"] = true,
                ["markdown"] = true,
                ["yaml"] = true,
                ["help"] = false,
                ["gitcommit"] = false,
                ["gitrebase"] = false,
                ["hgcommit"] = false,
                ["svn"] = false,
                ["cvs"] = false,
            }
            
            -- Customize key mappings for Copilot
            vim.g.copilot_no_tab_map = true -- Disable Tab for suggestions
            vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
            
            -- Additional Copilot settings
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_tab_fallback = ""
            
            -- For diagnostic messages
            vim.cmd([[
                highlight CopilotSuggestion guifg=#555555 ctermfg=8
            ]])
        end,
    },
}
