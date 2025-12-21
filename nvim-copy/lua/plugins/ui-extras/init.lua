-- Modern UI and aesthetic plugins
return {
    -- Smooth scrolling
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require("neoscroll").setup({
                mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
                hide_cursor = true,
                stop_eof = true,
                respect_scrolloff = false,
                cursor_scrolls_alone = true,
                easing_function = nil,
                pre_hook = nil,
                post_hook = nil,
                performance_mode = false,
            })
        end,
    },

    -- Winbar with breadcrumbs
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = "gruvbox-material",
            include_buftypes = { "" },
            exclude_filetypes = { "netrw", "toggleterm" },
            show_modified = false,
            kinds = {
                File = "󰈙",
                Module = "󰆧",
                Namespace = "󰌗",
                Package = "󰏖",
                Class = "󰌗",
                Method = "󰆧",
                Property = "󰜢",
                Field = "󰜢",
                Constructor = "󰆧",
                Enum = "󰕘",
                Interface = "󰕘",
                Function = "󰊕",
                Variable = "󰀫",
                Constant = "󰏿",
                String = "󰀬",
                Number = "󰎠",
                Boolean = "󰨙",
                Array = "󰅪",
                Object = "󰅩",
                Key = "󰌋",
                Null = "󰟢",
                EnumMember = "󰕘",
                Struct = "󰌗",
                Event = "󰉁",
                Operator = "󰆕",
                TypeParameter = "󰊄",
            },
        },
    },

    -- Dashboard
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("dashboard").setup({
                theme = "hyper",
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        { desc = " Update", group = "@property", action = "Lazy update", key = "u" },
                        {
                            icon = " ",
                            icon_hl = "@variable",
                            desc = "Files",
                            group = "Label",
                            action = "Telescope find_files",
                            key = "f",
                        },
                        {
                            desc = " Apps",
                            group = "DiagnosticHint",
                            action = "Telescope app",
                            key = "a",
                        },
                        {
                            desc = " dotfiles",
                            group = "Number",
                            action = "Telescope dotfiles",
                            key = "d",
                        },
                    },
                    project = { enable = true, limit = 8, icon = "󰏓", label = " Projects:", action = "Telescope find_files cwd=" },
                    mru = { limit = 10, icon = "", label = " Recent files:", cwd_only = false },
                    footer = function()
                        local stats = require("lazy").stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                        return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
                    end,
                },
            })
        end,
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },

    -- Better vim.ui and notifications
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- Better vim.ui.input
            input = {
                enabled = true,
                win = {
                    relative = "cursor",
                    row = -3,
                    col = 0,
                    border = "rounded",
                    title_pos = "center",
                    style = "minimal",
                    winblend = 0, -- No transparency (opaque)
                },
                expand = true,
            },
            -- Better vim.ui.select
            select = {
                enabled = true,
                backend = "telescope",
            },
            -- Notifications
            notifier = {
                enabled = true,
                timeout = 3000,
                width = { min = 40, max = 0.4 },
                height = { min = 1, max = 0.6 },
                margin = { top = 0, right = 1, bottom = 0 },
                padding = true,
                sort = { "level", "added" },
                level = vim.log.levels.TRACE,
                winblend = 0, -- No transparency (opaque)
                icons = {
                    error = "󰅚 ",
                    warn = "󰀪 ",
                    info = "󰋽 ",
                    debug = "󰃤 ",
                    trace = "󰌕 ",
                },
                keep = function(notif)
                    return vim.fn.getcmdpos() > 0
                end,
                style = "compact",
                top_down = true,
            },
            -- Quick file operations
            quickfile = { enabled = true },
            -- Status column enhancements
            statuscolumn = { enabled = false }, -- Disable if you have other statuscolumn plugins
            -- Word highlighting
            words = { enabled = true },
            -- Smooth scrolling (disable if you prefer neoscroll)
            scroll = { enabled = false },
        },
    },


}
