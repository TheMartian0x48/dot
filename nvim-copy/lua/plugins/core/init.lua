-- Core functionality plugins
return {
    -- Treesitter for syntax highlighting and parsing
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            -- "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            require("plugins.core.treesitter")
            -- require("plugins.core.treesitter-context")
        end,
    },

    -- Telescope for fuzzy finding
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
        },
        config = function()
            require("plugins.core.telescope")
        end,
    },

    -- Which-key for keymap hints
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("plugins.core.which-key")
        end,
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
}
