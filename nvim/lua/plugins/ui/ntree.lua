-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable 24-bit colour
vim.opt.termguicolors = true

-- Helper function for floating window configuration
local function get_float_config()
    local screen_w = vim.api.nvim_get_option("columns")
    local screen_h = vim.api.nvim_get_option("lines")

    local window_w = math.floor(screen_w * 0.8)
    local window_h = math.floor(screen_h * 0.8)

    local window_w_int = math.floor(window_w)
    local window_h_int = math.floor(window_h)

    local center_x = math.floor((screen_w - window_w) / 2)
    local center_y = math.floor((screen_h - window_h) / 2)

    return {
        relative = "editor",
        width = window_w_int,
        height = window_h_int,
        col = center_x,
        row = center_y,
        style = "minimal",
        border = "rounded",
    }
end

-- Key mappings function
local function setup_keymaps(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Essential navigation
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
    vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
    vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
    vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
    vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
    vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))

    -- File operations
    vim.keymap.set('n', 'a', api.fs.create, opts('Create File Or Directory'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
    vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
    vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
    vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
    vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))

    -- Tree operations
    vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
    vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
    vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
    vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
    vim.keymap.set('n', 'q', api.tree.close, opts('Close Tree'))

    -- Toggles
    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Filter: Dotfiles'))
    vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Filter: Git Ignore'))
    vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Filter: Hidden'))
    vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
    vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
    vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))

    -- Bookmarks and info
    vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
    vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
    vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle Filter: No Buffer'))
    vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
    vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
    vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))

    -- System operations
    vim.keymap.set('n', 'ge', api.fs.copy.basename, opts('Copy Basename'))
    vim.keymap.set('n', 'gx', api.node.run.system, opts('Run System'))
    vim.keymap.set('n', '<C-r>', api.tree.reload, opts('Refresh'))
end

-- Enhanced nvim-tree setup
require("nvim-tree").setup({
    -- Disable netrw completely
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = false,
    hijack_unnamed_buffer_when_opening = false,

    -- Auto-reload on focus
    reload_on_bufenter = false,
    respect_buf_cwd = true,

    -- Sync with cwd
    sync_root_with_cwd = true,

    -- Update focused file
    update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
    },

    -- System open
    system_open = {
        cmd = nil,
        args = {},
    },

    -- View configuration
    view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 35,
        side = "left",
        preserve_window_proportions = false,
        number = true,
        relativenumber = true,
        signcolumn = "yes",
        -- Uncomment for floating window
        -- float = {
        --     enable = true,
        --     quit_on_focus_loss = true,
        --     open_win_config = get_float_config,
        -- },
    },

    -- Renderer configuration
    renderer = {
        add_trailing = false,
        group_empty = true,
        highlight_git = true,
        full_name = false,
        highlight_diagnostics = "icon",
        highlight_hidden = "icon",
        highlight_clipboard = "name",
        highlight_opened_files = "all",
        highlight_modified = "all",
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = " ",
                edge = "|",
                item = "|",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
            webdev_colors = true,
            git_placement = "before",
            modified_placement = "after",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
                modified = true,
            },
            glyphs = {
                default = "󰈚",
                symlink = "",
                bookmark = "󰆤",
                modified = "●",
                folder = {
                    arrow_closed = "▸",
                    arrow_open = "▾",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "package.json" },
        symlink_destination = true,
    },

    -- Hijack directories
    hijack_directories = {
        enable = true,
        auto_open = true,
    },

    -- Live filter
    live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
    },

    -- File system watcher
    filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
    },

    -- Git integration
    git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 400,
    },

    -- Modified files
    modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
    },

    -- Filters
    filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = { "^.git$", "node_modules", ".cache" },
        exclude = { ".gitignore", ".env" },
    },

    -- Diagnostics (disabled to prevent conflicts with modern LSP setup)
    diagnostics = {
        enable = false,
    },

    -- Actions
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        expand_all = {
            max_folder_discovery = 300,
            exclude = {},
        },
        file_popup = {
            open_win_config = {
                col = 1,
                row = 1,
                relative = "cursor",
                border = "shadow",
                style = "minimal",
            },
        },
        open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
                enable = true,
                picker = "default",
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
        remove_file = {
            close_window = true,
        },
    },

    -- Trash (requires trash-cli on Linux)
    trash = {
        cmd = "gio trash",
    },

    -- Tab behavior
    tab = {
        sync = {
            open = false,
            close = false,
            ignore = {},
        },
    },

    -- Notifications
    notify = {
        threshold = vim.log.levels.INFO,
    },

    -- Help configuration
    help = {
        sort_by = "key",
    },

    -- UI configuration
    ui = {
        confirm = {
            remove = true,
            trash = true,
        },
    },

    -- Log configuration
    log = {
        enable = false,
        truncate = false,
        types = {
            all = false,
            config = false,
            copy_paste = false,
            dev = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
        },
    },

    -- Key mappings
    on_attach = setup_keymaps,
})

-- Global key mappings for nvim-tree
vim.keymap.set('n', '<leader>E', '<cmd>NvimTreeFindFile<CR>', { desc = 'Find current file in explorer' })

-- Auto commands for enhanced functionality
local augroup = vim.api.nvim_create_augroup("NvimTreeConfig", { clear = true })

-- Auto-close nvim-tree if it's the last window
-- vim.api.nvim_create_autocmd("QuitPre", {
--     group = augroup,
--     callback = function()
--         local invalid_win = {}
--         local wins = vim.api.nvim_list_wins()
--         for _, w in ipairs(wins) do
--             local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
--             if bufname:match("NvimTree_") ~= nil then
--                 table.insert(invalid_win, w)
--             end
--         end
--         if #invalid_win == #wins - 1 then
--             -- Should quit, so we close all invalid windows.
--             for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
--         end
--     end
-- })

-- Open nvim-tree when entering a directory
vim.api.nvim_create_autocmd("VimEnter", {
    group = augroup,
    callback = function(data)
        local directory = vim.fn.isdirectory(data.file) == 1
        if not directory then
            return
        end
        vim.cmd.cd(data.file)
        require("nvim-tree.api").tree.open()
    end
})
