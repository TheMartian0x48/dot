-- Productivity enhancement plugins
return {
    -- Session management
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {
            dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
            options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" }
        },
        keys = {
            { "<leader>Ss", function() require("persistence").save() end,                desc = "Save Session" },
            { "<leader>Sr", function() require("persistence").load() end,                desc = "Restore Session" },
            { "<leader>Sl", function() require("persistence").load({ last = true }) end, desc = "Load Last Session" },
            { "<leader>Sd", function() require("persistence").stop() end,                desc = "Don't Save Session" },
        },
    },

    -- Enhanced commenting
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("Comment").setup({
                pre_hook = function(ctx)
                    local U = require("Comment.utils")
                    local location = nil
                    if ctx.ctype == U.ctype.blockwise then
                        location = require("ts_context_commentstring.utils").get_cursor_location()
                    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                        location = require("ts_context_commentstring.utils").get_visual_start_location()
                    end
                    return require("ts_context_commentstring.internal").calculate_commentstring({
                        key = ctx.ctype == U.ctype.linewise and "__default" or "__multiline",
                        location = location,
                    })
                end,
            })
        end,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
    },



    -- Project management
    -- {
    --     "ahmedkhalf/project.nvim",
    --     config = function()
    --         require("project_nvim").setup({
    --             detection_methods = { "lsp", "pattern" },
    --             patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Cargo.toml" },
    --             ignore_lsp = {},
    --             exclude_dirs = {},
    --             show_hidden = false,
    --             silent_chdir = true,
    --             scope_chdir = "global",
    --             datapath = vim.fn.stdpath("data"),
    --         })
    --     end,
    -- },

    -- Terminal enhancement
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<c-\>]],
                hide_numbers = true,
                shade_filetypes = {},
                shade_terminals = true,
                shading_factor = 2,
                start_in_insert = true,
                insert_mappings = true,
                persist_size = true,
                direction = "float",
                close_on_exit = true,
                shell = vim.o.shell,
                float_opts = {
                    border = "curved",
                    winblend = 0,
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    },
                },
            })
        end,
        keys = {
            { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",              desc = "Float Terminal" },
            { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal Terminal" },
            { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>",   desc = "Vertical Terminal" },
        },
    },



    -- Buffer management
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    numbers = "none",
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    left_mouse_command = "buffer %d",
                    middle_mouse_command = nil,
                    indicator = {
                        icon = "▎",
                        style = "icon",
                    },
                    buffer_close_icon = "󰅖",
                    modified_icon = "●",
                    close_icon = "",
                    left_trunc_marker = "",
                    right_trunc_marker = "",
                    max_name_length = 30,
                    max_prefix_length = 30,
                    tab_size = 21,
                    diagnostics = "nvim_lsp",
                    diagnostics_update_in_insert = false,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = true,
                        },
                    },
                    color_icons = true,
                    show_buffer_icons = true,
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    show_tab_indicators = true,
                    persist_buffer_sort = true,
                    separator_style = "slant",
                    enforce_regular_tabs = true,
                    always_show_bufferline = true,
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = { "close" },
                    },
                },
            })
        end,
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
            { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete other buffers" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete buffers to the right" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete buffers to the left" },
            { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
            { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
            { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
            { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
        },
    },

    -- Better notifications
    {
        "rcarriga/nvim-notify",
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Dismiss all Notifications",
            },
        },
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
            on_open = function(win)
                vim.api.nvim_win_set_config(win, { zindex = 100 })
            end,
        },
        init = function()
            vim.notify = require("notify")
        end,
    },

    -- File operations
    {
        "stevearc/oil.nvim",
        opts = {
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = false,
                natural_order = true,
                is_always_hidden = function(name, _)
                    return name == ".." or name == ".git"
                end,
            },
            win_options = {
                wrap = false,
                signcolumn = "no",
                cursorcolumn = false,
                foldcolumn = "0",
                spell = false,
                list = false,
                conceallevel = 3,
                concealcursor = "nvic",
            },
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-h>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
        },
        keys = {
            { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
        },
    },

    -- Sticky Notes - Persistent floating notes buffer
    {
        name = "stickynotes",
        dir = vim.fn.stdpath("config") .. "/lua/plugins/productivity",
        config = function()
            require("plugins.productivity.stickynotes").setup({
                -- Custom configuration can be added here
                window = {
                    width = 70,
                    height = 25,
                    border = "rounded",
                    title = " 📝 Sticky Notes ",
                    title_pos = "center",
                },
                auto_save = true,
                save_on_focus_lost = true,
            })
        end,
        keys = {
            { "<leader>sn", desc = "Toggle Sticky Notes" },
            { "<leader>sc", desc = "Clear Sticky Notes" },
        },
    },
}
