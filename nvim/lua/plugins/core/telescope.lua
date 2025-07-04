-- Enhanced Telescope Configuration
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        winblend = 0, -- No transparency (opaque)

        -- Improved file ignore patterns
        file_ignore_patterns = {
            "%.git/",
            "node_modules/",
            "%.npm/",
            "%.cache/",
            "%.vscode/",
            "%.DS_Store",
            "target/",
            "build/",
            "dist/",
            "%.o",
            "%.a",
            "%.out",
            "%.class",
            "%.pdf",
            "%.mkv",
            "%.mp4",
            "%.zip"
        },

        -- Enhanced sorting and search
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",

        -- Better search behavior
        path_display = { "truncate" },
        dynamic_preview_title = true,
        results_title = false,

        -- Improved mappings
        mappings = {
            i = {
                -- Navigation
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                -- Actions
                ["<C-h>"] = "which_key",
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                -- Close
                ["<C-c>"] = actions.close,
                ["<Esc>"] = actions.close,

                -- Scroll preview
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<C-u>"] = actions.preview_scrolling_up,

                -- Send to quickfix
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            n = {
                -- Navigation
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                -- Selection
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                -- Preview
                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                -- Close
                ["q"] = actions.close,
                ["<Esc>"] = actions.close,
            },
        },

        -- Layout configuration
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },

        -- Appearance
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" },

        -- Performance
        cache_picker = {
            num_pickers = 5,
        },
    },

    pickers = {
        -- Buffer picker
        buffers = {
            theme = "cursor",
            previewer = false,
            layout_config = {
                width = 0.7,
                height = 0.4,
            },
            path_display = { "filename_first" },
            mappings = {
                i = {
                    ["<C-d>"] = actions.delete_buffer,
                },
                n = {
                    ["dd"] = actions.delete_buffer,
                },
            },
            sort_lastused = true,
            sort_mru = true,
            ignore_current_buffer = true,
        },

        -- File finder
        find_files = {
            path_display = { "filename_first" },
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            layout_config = {
                width = 0.8,
                height = 0.6,
            },
        },

        -- Live grep
        live_grep = {
            path_display = { "filename_first" },
            layout_config = {
                width = 0.8,
                height = 0.6,
            },
            additional_args = function()
                return { "--hidden", "--glob", "!**/.git/*" }
            end,
        },

        -- Git files
        git_files = {
            path_display = { "filename_first" },
            layout_config = {
                width = 0.8,
                height = 0.6,
            },
        },

        -- Help tags
        help_tags = {
            layout_config = {
                width = 0.8,
                height = 0.6,
            },
        },

        -- LSP pickers
        lsp_references = {
            layout_config = {
                width = 0.8,
                height = 0.4,
            },
        },

        lsp_definitions = {
            layout_config = {
                width = 0.8,
                height = 0.4,
            },
        },

        lsp_document_symbols = {
            layout_config = {
                width = 0.8,
                height = 0.5,
            },
        },

        lsp_workspace_symbols = {
            layout_config = {
                width = 0.8,
                height = 0.5,
            },
        },

        -- Diagnostics
        diagnostics = {
            layout_config = {
                width = 0.8,
                height = 0.6,
            },
        },

        -- Quickfix
        quickfix = {
            layout_config = {
                width = 0.8,
                height = 0.6,
            },
        },

        -- Colorscheme picker
        colorscheme = {
            enable_preview = true,
            theme = "cursor",
            layout_config = {
                width = 0.5,
                height = 0.4,
            },
        },
    },

    extensions = {
        -- File browser extension
        file_browser = {
            hijack_netrw = true,
            mappings = {
                ["i"] = {
                    -- your custom insert mode mappings
                },
                ["n"] = {
                    -- your custom normal mode mappings
                },
            },
        },

        -- UI select
        ["ui-select"] = {
            require("telescope.themes").get_cursor({
                -- even more opts
            }),
        },
    },
})

-- Load extensions if available
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "file_browser")
pcall(telescope.load_extension, "ui-select")

-- Additional key mappings for common telescope functions
local builtin = require("telescope.builtin")

-- Define custom telescope functions
local M = {}

-- Smart file finder (git files if in git repo, otherwise find files)
M.find_files_smart = function()
    local git_dir = vim.fn.finddir(".git", ".;")
    if git_dir ~= "" then
        local ok, err = pcall(builtin.git_files)
        if not ok then
            vim.notify("Git files not available, falling back to find_files", vim.log.levels.INFO)
            builtin.find_files()
        end
    else
        builtin.find_files()
    end
end

-- Search in current buffer
M.current_buffer_fuzzy_find = function()
    local ok, err = pcall(function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_cursor({
            winblend = 0, -- No transparency (opaque)
            previewer = false,
        }))
    end)
    if not ok then
        vim.notify("Cannot search in empty buffer", vim.log.levels.WARN)
    end
end

-- Search for word under cursor
M.grep_string_visual = function()
    local word = vim.fn.expand("<cword>")
    if word == "" then
        vim.notify("No word under cursor", vim.log.levels.WARN)
        builtin.live_grep()
    else
        builtin.grep_string({ search = word })
    end
end

-- Safe buffer picker with fallback
M.buffers_safe = function()
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    if #buffers == 0 then
        vim.notify("No buffers available", vim.log.levels.INFO)
        return
    end

    local ok, err = pcall(builtin.buffers)
    if not ok then
        vim.notify("Error opening buffer picker: " .. tostring(err), vim.log.levels.ERROR)
    end
end

-- Make functions available globally
_G.telescope_custom = M
