-- Git integration plugins
return {
    -- Git integration - Comprehensive setup
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("neogit").setup({
                -- Configure Neogit
                integrations = {
                    telescope = true,
                    diffview = true,
                },
                -- Use telescope for branch/commit selection
                commit_editor = {
                    kind = "tab",
                },
                -- Disable some default keymaps to avoid conflicts
                disable_builtin_notifications = false,
                -- Configure signs
                signs = {
                    hunk = { "󰐕", "󰐕" },
                    item = { "▸", "▾" },
                    section = { "▸", "▾" },
                },
            })
        end,
    },
    {
        "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("diffview").setup({
                diff_binaries = false,
                enhanced_diff_hl = true,
                git_cmd = { "git" },
                use_icons = true,
                show_help_hints = true,
                watch_index = true,
                icons = {
                    folder_closed = "󰉋",
                    folder_open = "󰝰",
                },
                signs = {
                    fold_closed = "󰅂",
                    fold_open = "󰅀",
                    done = "✓",
                },
                view = {
                    default = {
                        layout = "diff2_horizontal",
                        winbar_info = false,
                    },
                    merge_tool = {
                        layout = "diff3_horizontal",
                        disable_diagnostics = true,
                        winbar_info = true,
                    },
                    file_history = {
                        layout = "diff2_horizontal",
                        winbar_info = false,
                    },
                },
                file_panel = {
                    listing_style = "tree",
                    tree_options = {
                        flatten_dirs = true,
                        folder_statuses = "only_folded",
                    },
                    win_config = {
                        position = "left",
                        width = 35,
                        win_opts = {}
                    },
                },
                file_history_panel = {
                    log_options = {
                        git = {
                            single_file = {
                                diff_merges = "combined",
                            },
                            multi_file = {
                                diff_merges = "first-parent",
                            },
                        },
                    },
                    win_config = {
                        position = "bottom",
                        height = 16,
                        win_opts = {}
                    },
                },
                commit_log_panel = {
                    win_config = {
                        win_opts = {},
                    }
                },
                default_args = {
                    DiffviewOpen = {},
                    DiffviewFileHistory = {},
                },
                hooks = {},
                keymaps = {
                    disable_defaults = false,
                    view = {
                        { "n", "<tab>",      require("diffview.actions").select_next_entry,         { desc = "Open the diff for the next file" } },
                        { "n", "<s-tab>",    require("diffview.actions").select_prev_entry,         { desc = "Open the diff for the previous file" } },
                        { "n", "gf",         require("diffview.actions").goto_file_edit,            { desc = "Open the file in the previous tabpage" } },
                        { "n", "<C-w><C-f>", require("diffview.actions").goto_file_split,           { desc = "Open the file in a new split" } },
                        { "n", "<C-w>gf",    require("diffview.actions").goto_file_tab,             { desc = "Open the file in a new tabpage" } },
                        { "n", "<leader>e",  require("diffview.actions").focus_files,               { desc = "Bring focus to the file panel" } },
                        { "n", "<leader>b",  require("diffview.actions").toggle_files,              { desc = "Toggle the file panel." } },
                        { "n", "g<C-x>",     require("diffview.actions").cycle_layout,              { desc = "Cycle through available layouts." } },
                        { "n", "[x",         require("diffview.actions").prev_conflict,             { desc = "In the merge-tool: jump to the previous conflict" } },
                        { "n", "]x",         require("diffview.actions").next_conflict,             { desc = "In the merge-tool: jump to the next conflict" } },
                        { "n", "[h",         "]c",                                                  { desc = "Jump to previous diff hunk" } },
                        { "n", "]h",         "]c",                                                  { desc = "Jump to next diff hunk" } },
                        { "n", "<leader>co", require("diffview.actions").conflict_choose("ours"),   { desc = "Choose the OURS version of a conflict" } },
                        { "n", "<leader>ct", require("diffview.actions").conflict_choose("theirs"), { desc = "Choose the THEIRS version of a conflict" } },
                        { "n", "<leader>cb", require("diffview.actions").conflict_choose("base"),   { desc = "Choose the BASE version of a conflict" } },
                        { "n", "<leader>ca", require("diffview.actions").conflict_choose("all"),    { desc = "Choose all the versions of a conflict" } },
                        { "n", "dx",         require("diffview.actions").conflict_choose("none"),   { desc = "Delete the conflict region" } },
                    },
                    diff1 = {
                        { "n", "g?", require("diffview.actions").help({ "view", "diff1" }), { desc = "Open the help panel" } },
                        { "n", "[h", "[c",                                                  { desc = "Jump to previous diff hunk" } },
                        { "n", "]h", "]c",                                                  { desc = "Jump to next diff hunk" } },
                    },
                    diff2 = {
                        { "n", "g?", require("diffview.actions").help({ "view", "diff2" }), { desc = "Open the help panel" } },
                        { "n", "[h", "[c",                                                  { desc = "Jump to previous diff hunk" } },
                        { "n", "]h", "]c",                                                  { desc = "Jump to next diff hunk" } },
                    },
                    diff3 = {
                        { "n", "g?", require("diffview.actions").help({ "view", "diff3" }), { desc = "Open the help panel" } },
                        { "n", "[h", "[c",                                                  { desc = "Jump to previous diff hunk" } },
                        { "n", "]h", "]c",                                                  { desc = "Jump to next diff hunk" } },
                    },
                    diff4 = {
                        { "n", "g?", require("diffview.actions").help({ "view", "diff4" }), { desc = "Open the help panel" } },
                        { "n", "[h", "[c",                                                  { desc = "Jump to previous diff hunk" } },
                        { "n", "]h", "]c",                                                  { desc = "Jump to next diff hunk" } },
                    },
                    file_panel = {
                        { "n", "j",             require("diffview.actions").next_entry,          { desc = "Bring the cursor to the next file entry" } },
                        { "n", "<down>",        require("diffview.actions").next_entry,          { desc = "Bring the cursor to the next file entry" } },
                        { "n", "k",             require("diffview.actions").prev_entry,          { desc = "Bring the cursor to the previous file entry." } },
                        { "n", "<up>",          require("diffview.actions").prev_entry,          { desc = "Bring the cursor to the previous file entry." } },
                        { "n", "<cr>",          require("diffview.actions").select_entry,        { desc = "Open the diff for the selected entry." } },
                        { "n", "o",             require("diffview.actions").select_entry,        { desc = "Open the diff for the selected entry." } },
                        { "n", "l",             require("diffview.actions").select_entry,        { desc = "Open the diff for the selected entry." } },
                        { "n", "<2-LeftMouse>", require("diffview.actions").select_entry,        { desc = "Open the diff for the selected entry." } },
                        { "n", "-",             require("diffview.actions").toggle_stage_entry,  { desc = "Stage / unstage the selected entry." } },
                        { "n", "S",             require("diffview.actions").stage_all,           { desc = "Stage all entries." } },
                        { "n", "U",             require("diffview.actions").unstage_all,         { desc = "Unstage all entries." } },
                        { "n", "X",             require("diffview.actions").restore_entry,       { desc = "Restore entry to the state on the left side." } },
                        { "n", "L",             require("diffview.actions").open_commit_log,     { desc = "Open the commit log panel." } },
                        { "n", "zo",            require("diffview.actions").open_fold,           { desc = "Expand fold" } },
                        { "n", "h",             require("diffview.actions").close_fold,          { desc = "Collapse fold" } },
                        { "n", "zc",            require("diffview.actions").close_fold,          { desc = "Collapse fold" } },
                        { "n", "za",            require("diffview.actions").toggle_fold,         { desc = "Toggle fold" } },
                        { "n", "zR",            require("diffview.actions").open_all_folds,      { desc = "Expand all folds" } },
                        { "n", "zM",            require("diffview.actions").close_all_folds,     { desc = "Collapse all folds" } },
                        { "n", "<c-b>",         require("diffview.actions").scroll_view(-0.25),  { desc = "Scroll the view up" } },
                        { "n", "<c-f>",         require("diffview.actions").scroll_view(0.25),   { desc = "Scroll the view down" } },
                        { "n", "<tab>",         require("diffview.actions").select_next_entry,   { desc = "Open the diff for the next file" } },
                        { "n", "<s-tab>",       require("diffview.actions").select_prev_entry,   { desc = "Open the diff for the previous file" } },
                        { "n", "gf",            require("diffview.actions").goto_file_edit,      { desc = "Open the file in the previous tabpage" } },
                        { "n", "<C-w><C-f>",    require("diffview.actions").goto_file_split,     { desc = "Open the file in a new split" } },
                        { "n", "<C-w>gf",       require("diffview.actions").goto_file_tab,       { desc = "Open the file in a new tabpage" } },
                        { "n", "i",             require("diffview.actions").listing_style,       { desc = "Toggle between 'list' and 'tree' views" } },
                        { "n", "f",             require("diffview.actions").toggle_flatten_dirs, { desc = "Flatten empty subdirectories in tree listing style." } },
                        { "n", "R",             require("diffview.actions").refresh_files,       { desc = "Update stats and entries in the file list." } },
                        { "n", "<leader>e",     require("diffview.actions").focus_files,         { desc = "Bring focus to the file panel" } },
                        { "n", "<leader>b",     require("diffview.actions").toggle_files,        { desc = "Toggle the file panel" } },
                        { "n", "g<C-x>",        require("diffview.actions").cycle_layout,        { desc = "Cycle through available layouts." } },
                        { "n", "g?",            require("diffview.actions").help("file_panel"),  { desc = "Open the help panel" } },
                    },
                    file_history_panel = {
                        { "n", "g!",            require("diffview.actions").options,                    { desc = "Open the option panel" } },
                        { "n", "<C-A-d>",       require("diffview.actions").open_in_diffview,           { desc = "Open the entry under the cursor in a diffview" } },
                        { "n", "y",             require("diffview.actions").copy_hash,                  { desc = "Copy the commit hash of the entry under the cursor" } },
                        { "n", "L",             require("diffview.actions").open_commit_log,            { desc = "Show commit details" } },
                        { "n", "zR",            require("diffview.actions").open_all_folds,             { desc = "Expand all folds" } },
                        { "n", "zM",            require("diffview.actions").close_all_folds,            { desc = "Collapse all folds" } },
                        { "n", "j",             require("diffview.actions").next_entry,                 { desc = "Bring the cursor to the next file entry" } },
                        { "n", "<down>",        require("diffview.actions").next_entry,                 { desc = "Bring the cursor to the next file entry" } },
                        { "n", "k",             require("diffview.actions").prev_entry,                 { desc = "Bring the cursor to the previous file entry." } },
                        { "n", "<up>",          require("diffview.actions").prev_entry,                 { desc = "Bring the cursor to the previous file entry." } },
                        { "n", "<cr>",          require("diffview.actions").select_entry,               { desc = "Open the diff for the selected entry." } },
                        { "n", "o",             require("diffview.actions").select_entry,               { desc = "Open the diff for the selected entry." } },
                        { "n", "<2-LeftMouse>", require("diffview.actions").select_entry,               { desc = "Open the diff for the selected entry." } },
                        { "n", "<c-b>",         require("diffview.actions").scroll_view(-0.25),         { desc = "Scroll the view up" } },
                        { "n", "<c-f>",         require("diffview.actions").scroll_view(0.25),          { desc = "Scroll the view down" } },
                        { "n", "<tab>",         require("diffview.actions").select_next_entry,          { desc = "Open the diff for the next file" } },
                        { "n", "<s-tab>",       require("diffview.actions").select_prev_entry,          { desc = "Open the diff for the previous file" } },
                        { "n", "gf",            require("diffview.actions").goto_file_edit,             { desc = "Open the file in the previous tabpage" } },
                        { "n", "<C-w><C-f>",    require("diffview.actions").goto_file_split,            { desc = "Open the file in a new split" } },
                        { "n", "<C-w>gf",       require("diffview.actions").goto_file_tab,              { desc = "Open the file in a new tabpage" } },
                        { "n", "<leader>e",     require("diffview.actions").focus_files,                { desc = "Bring focus to the file panel" } },
                        { "n", "<leader>b",     require("diffview.actions").toggle_files,               { desc = "Toggle the file panel" } },
                        { "n", "g<C-x>",        require("diffview.actions").cycle_layout,               { desc = "Cycle through available layouts." } },
                        { "n", "g?",            require("diffview.actions").help("file_history_panel"), { desc = "Open the help panel" } },
                    },
                    option_panel = {
                        { "n", "<tab>", require("diffview.actions").select_entry,         { desc = "Change the current option" } },
                        { "n", "q",     require("diffview.actions").close,                { desc = "Close the diff" } },
                        { "n", "g?",    require("diffview.actions").help("option_panel"), { desc = "Open the help panel" } },
                    },
                    help_panel = {
                        { "n", "q",     require("diffview.actions").close, { desc = "Close help menu" } },
                        { "n", "<esc>", require("diffview.actions").close, { desc = "Close help menu" } },
                    },
                },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "▎" },
                    change = { text = "▎" },
                    delete = { text = "▸" },
                    topdelete = { text = "▾" },
                    changedelete = { text = "▎" },
                    untracked = { text = "┆" },
                },
                signs_staged = {
                    add = { text = "▎" },
                    change = { text = "▎" },
                    delete = { text = "▸" },
                    topdelete = { text = "▾" },
                    changedelete = { text = "▎" },
                    untracked = { text = "┆" },
                },
                signs_staged_enable = true,
                signcolumn = true,
                numhl = true,
                linehl = false,
                word_diff = false,
                watch_gitdir = {
                    follow_files = true,
                },
                auto_attach = true,
                attach_to_untracked = true,
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol",
                    delay = 500,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                    use_focus = true,
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil,
                max_file_length = 40000,
                preview_config = {
                    border = "rounded",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
                -- Remove on_attach - we handle keymaps in which-key
            })
        end,
    },
}
