-- Which-key configuration for keymap hints and organization
local wk = require("which-key")
local git = require("plugins.dev.git")
local terminal = require("plugins.core.terminal")
local fileops = require("plugins.core.fileops")
local navigation = require("plugins.core.navigation")

-- Setup which-key with custom options
wk.setup({
    preset = "modern",
    delay = function(ctx)
        return ctx.plugin and 0 or 200
    end,
    expand = 1,
    notify = true,
    triggers = {
        { "<auto>", mode = "nixsotc" },
        { "s",      mode = { "n", "v" } },
    },
    win = {
        border = "rounded",
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
        wo = {
            winblend = 0, -- No transparency (opaque)
        },
    },
    layout = {
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
    },
    keys = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
    },
    sort = { "local", "order", "group", "alphanum", "mod" },
    icons = {
        breadcrumb = "»",
        separator = "󰁔",
        group = "󰙅",
        ellipsis = "…",
        mappings = true,
        rules = false,
        colors = true,
        keys = {
            Up = "󰁝 ",
            Down = "󰁅 ",
            Left = "󰁍 ",
            Right = "󰁔 ",
            C = "󰘴 ",
            M = "󰘵 ",
            D = "󰘳 ",
            S = "󰘶 ",
            CR = "󰌑 ",
            Esc = "󱊷 ",
            ScrollWheelDown = "󱕐 ",
            ScrollWheelUp = "󱕑 ",
            NL = "󰌑 ",
            BS = "󰁮 ",
            Space = "󱁐 ",
            Tab = "󰌒 ",
            F1 = "󱊫 ",
            F2 = "󱊬 ",
            F3 = "󱊭 ",
            F4 = "󱊮 ",
            F5 = "󱊯 ",
            F6 = "󱊰 ",
            F7 = "󱊱 ",
            F8 = "󱊲 ",
            F9 = "󱊳 ",
            F10 = "󱊴 ",
            F11 = "󱊵 ",
            F12 = "󱊶 ",
        },
    },
})

-- Register key mappings with descriptions
wk.add({
    -- File operations (completely redesigned)
    { "<leader>f", group = "📁 File" },

    -- Core Finding (Direct access - most used)
    { "<leader>ff", fileops.find_files, desc = "Find Files" },
    { "<leader>fd", fileops.find_in_directory, desc = "Find in Directory" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },

    -- Recent Files
    { "<leader>fr", group = "🕒 Recent" },
    { "<leader>fra", fileops.recent_all, desc = "All Recent Files" },
    { "<leader>frp", fileops.recent_project, desc = "Project Recent" },
    { "<leader>frs", fileops.recent_session, desc = "Session Recent" },
    { "<leader>frf", fileops.recent_frequent, desc = "Frequent Files" },
    { "<leader>frc", fileops.recent_by_category, desc = "By Category" },
    { "<leader>frt", fileops.recent_by_type, desc = "By Type" },

    -- Project Operations
    { "<leader>fp", group = "📂 Project" },
    { "<leader>fpr", fileops.project_root_files, desc = "Project Root Files" },
    { "<leader>fpw", fileops.workspace_files, desc = "Workspace Files" },
    { "<leader>fpt", fileops.project_type_files, desc = "Project Type Files" },
    { "<leader>fpc", fileops.config_files, desc = "Config Files" },
    { "<leader>fpi", fileops.ignored_files, desc = "Ignored Files" },
    { "<leader>fps", fileops.project_structure, desc = "Project Structure" },

    -- Search & Grep
    { "<leader>fs", group = "🔍 Search" },
    { "<leader>fsl", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>fsc", fileops.grep_with_context, desc = "Grep with Context" },
    { "<leader>fsf", fileops.grep_by_type, desc = "Grep by Type" },
    { "<leader>fsw", fileops.grep_word, desc = "Grep Word" },
    { "<leader>fss", fileops.grep_selection, desc = "Grep Selection", mode = "v" },
    { "<leader>fsr", fileops.grep_replace, desc = "Grep & Replace" },
    { "<leader>fsh", fileops.search_history, desc = "Search History" },

    -- File Creation
    { "<leader>fn", group = "✨ New" },
    { "<leader>fnf", fileops.new_file, desc = "New File" },
    { "<leader>fnt", fileops.new_from_template, desc = "From Template" },
    { "<leader>fns", fileops.new_with_snippet, desc = "With Snippet" },
    { "<leader>fnp", fileops.new_project_file, desc = "Project File" },
    { "<leader>fnd", fileops.new_directory, desc = "New Directory" },
    { "<leader>fnc", fileops.copy_file, desc = "Copy File" },
    { "<leader>fnr", fileops.rename_file, desc = "Rename File" },

    -- File Operations
    { "<leader>fo", group = "⚙️ Operations" },
    { "<leader>for", fileops.rename, desc = "Rename" },
    { "<leader>fod", fileops.delete_file, desc = "Delete" },
    { "<leader>foc", fileops.copy, desc = "Copy" },
    { "<leader>fom", fileops.move_file, desc = "Move" },
    { "<leader>fop", fileops.file_permissions, desc = "Permissions" },
    { "<leader>foi", fileops.file_info, desc = "File Info" },

    -- Buffer operations (enhanced)
    { "<leader>b", group = "📄 Buffer" },
    { "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer" },
    { "<leader>bp", "<cmd>bprev<cr>", desc = "Previous Buffer" },
    { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer" },
    { "<leader>bD", "<cmd>bdelete!<cr>", desc = "Force Delete Buffer" },
    { "<leader>bl", "<cmd>Telescope buffers<cr>", desc = "List Buffers" },
    { "<leader>bf", "<cmd>bfirst<cr>", desc = "First Buffer" },
    { "<leader>bL", "<cmd>blast<cr>", desc = "Last Buffer" },
    { "<leader>bb", navigation.buffer_picker, desc = "Buffer Picker" },
    { "<leader>ba", navigation.alternate_buffer, desc = "Alternate Buffer" },
    { "<leader>br", navigation.recent_buffers, desc = "Recent Buffers" },
    { "<leader>bq", navigation.smart_close_buffer, desc = "Smart Close Buffer" },
    { "<leader>bj", navigation.jump_to_buffer_by_number, desc = "Jump to Buffer #" },

    -- Window operations (enhanced)
    { "<leader>w", group = "🪟 Window" },
    { "<leader>wh", "<C-w>h", desc = "Go to Left Window" },
    { "<leader>wj", "<C-w>j", desc = "Go to Lower Window" },
    { "<leader>wk", "<C-w>k", desc = "Go to Upper Window" },
    { "<leader>wl", "<C-w>l", desc = "Go to Right Window" },
    { "<leader>ws", "<C-w>s", desc = "Split Window Below" },
    { "<leader>wv", "<C-w>v", desc = "Split Window Right" },
    { "<leader>wc", "<C-w>c", desc = "Close Window" },
    { "<leader>wo", "<C-w>o", desc = "Close Other Windows" },
    { "<leader>w=", "<C-w>=", desc = "Equalize Window Sizes" },
    { "<leader>ww", "<C-w>w", desc = "Next Window" },
    { "<leader>wW", "<C-w>W", desc = "Previous Window" },
    { "<leader>wr", "<C-w>r", desc = "Rotate Windows" },
    { "<leader>wR", "<C-w>R", desc = "Rotate Windows Reverse" },
    { "<leader>wx", "<C-w>x", desc = "Exchange Windows" },

    -- File Explorer
    { "<leader>e", group = "🌳 Explorer" },
    { "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Explorer" },
    { "<leader>ef", "<cmd>NvimTreeFocus<cr>", desc = "Focus Explorer" },
    { "<leader>eF", "<cmd>NvimTreeFindFile<cr>", desc = "Find Current File" },
    { "<leader>er", "<cmd>NvimTreeRefresh<cr>", desc = "Refresh Explorer" },
    { "<leader>ec", "<cmd>NvimTreeCollapse<cr>", desc = "Collapse Explorer" },
    { "<leader>eo", "<cmd>Oil<cr>", desc = "Open Oil File Manager" },
    { "-", "<cmd>Oil<cr>", desc = "Open Parent Directory" },

    -- LSP operations
    { "<leader>l", group = "🔧 LSP" },

    -- Core LSP actions (keeping your existing ones + improvements)
    { "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to Definition" },
    { "<leader>li", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
    { "<leader>lt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definitions" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>lf", vim.lsp.buf.format, desc = "Format Document" },
    { "<leader>la", vim.lsp.buf.code_action, desc = "Code Actions" },
    { "<leader>las", function() vim.lsp.buf.code_action({ context = { only = { "source" } } }) end, desc = "Source Actions" },
    { "<leader>ln", vim.lsp.buf.rename, desc = "Rename Symbol" },
    { "<leader>lh", vim.lsp.buf.hover, desc = "Hover Documentation" },
    { "<leader>lk", vim.lsp.buf.signature_help, desc = "Signature Help" },

    -- References group - using 'le' for rEferences
    { "<leader>le", group = "🔗 References" },
    { "<leader>ler", "<cmd>Telescope lsp_references<cr>", desc = "References" },
    { "<leader>lei", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
    { "<leader>led", "<cmd>Telescope lsp_definitions<cr>", desc = "Definitions" },
    { "<leader>let", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definitions" },

    -- Refactoring actions - using 'lx' for eXtract/refactor
    { "<leader>lx", group = "🔧 Refactor" },
    { "<leader>lxf", function() vim.lsp.buf.code_action({ context = { only = { "refactor.extract.function" } } }) end, desc = "Extract Function" },
    { "<leader>lxv", function() vim.lsp.buf.code_action({ context = { only = { "refactor.extract.variable" } } }) end, desc = "Extract Variable" },
    { "<leader>lxi", function() vim.lsp.buf.code_action({ context = { only = { "refactor.inline" } } }) end, desc = "Inline" },
    { "<leader>lxn", function() vim.lsp.buf.rename(vim.fn.input("New name: ")) end, desc = "Rename (with input)" },

    -- Call hierarchy - using 'lc' for call hierarchy
    { "<leader>lc", group = "📞 Call Hierarchy" },
    { "<leader>lci", vim.lsp.buf.incoming_calls, desc = "Incoming Calls" },
    { "<leader>lco", vim.lsp.buf.outgoing_calls, desc = "Outgoing Calls" },

    -- Enhanced diagnostics management - using 'lm' for Medical/diagnostics
    { "<leader>lm", group = "🩺 Diagnostics" },
    { "<leader>lmd", vim.diagnostic.open_float, desc = "Show Line Diagnostics" },
    { "<leader>lml", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Buffer Diagnostics" },
    { "<leader>lmw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>lmr", vim.diagnostic.reset, desc = "Reset Diagnostics" },
    { "<leader>lmt", vim.diagnostic.toggle, desc = "Toggle Diagnostics" },
    { "<leader>lms", function() vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text }) end, desc = "Toggle Virtual Text" },

    -- Enhanced workspace management - using 'lw' for workspace
    { "<leader>lw", group = "🏢 Workspace" },
    { "<leader>lws", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
    { "<leader>lwd", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Dynamic Workspace Symbols" },
    { "<leader>lwa", vim.lsp.buf.add_workspace_folder, desc = "Add Workspace Folder" },
    { "<leader>lwr", vim.lsp.buf.remove_workspace_folder, desc = "Remove Workspace Folder" },
    { "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "List Workspace Folders" },
    { "<leader>lwx", "<cmd>LspRestart<cr>", desc = "Restart LSP" },

    -- Enhanced formatting options - using 'lp' for Pretty/format
    { "<leader>lp", group = "📝 Format" },
    { "<leader>lpf", vim.lsp.buf.format, desc = "Format Document" },
    { "<leader>lps", function() vim.lsp.buf.format({ range = true }) end, desc = "Format Selection", mode = "v" },
    { "<leader>lpo", function() vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } } }) end, desc = "Organize Imports" },
    { "<leader>lpa", function() vim.lsp.buf.code_action({ context = { only = { "source.fixAll" } } }) end, desc = "Fix All" },

    -- LSP info and debugging - using 'lz' for info (avoiding 'li' conflict)
    { "<leader>lz", group = "ℹ️ LSP Info" },
    { "<leader>lzi", "<cmd>LspInfo<cr>", desc = "LSP Info" },
    { "<leader>lzl", "<cmd>LspLog<cr>", desc = "LSP Log" },
    { "<leader>lzs", function() print(vim.inspect(vim.lsp.get_active_clients())) end, desc = "Active LSP Clients" },
    { "<leader>lzc", function() vim.lsp.buf.server_ready() end, desc = "Check Server Status" },

    -- Diagnostics/Trouble
    { "<leader>x", group = "🚨 Diagnostics" },
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
    { "<leader>xn", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
    { "<leader>xp", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },

    -- Git operations - ALL under <leader>g
    { "<leader>g", group = "🔀 Git" },

    -- Main Git interface
    { "<leader>gg", git.open_neogit, desc = "Git Status (Neogit)" },

    -- Branch operations
    { "<leader>gb", group = "🌿 Branch" },
    { "<leader>gbb", git.branch_checkout, desc = "Branch Checkout (Interactive)" },
    { "<leader>gbc", git.branch_create, desc = "Create New Branch" },
    { "<leader>gbd", git.branch_delete, desc = "Delete Branch (Interactive)" },
    { "<leader>gbr", git.branch_rename, desc = "Rename Current Branch" },
    { "<leader>gbm", git.branch_merge, desc = "Merge Branch (Interactive)" },
    { "<leader>gbl", git.branch_list, desc = "List All Branches" },
    { "<leader>gbp", git.branch_push, desc = "Push Current Branch" },

    -- Diff operations
    { "<leader>gd", group = "📊 Diff" },
    { "<leader>gdb", git.diff_with_branch, desc = "Diff with Branch" },
    { "<leader>gdp", git.diff_with_prev_commit, desc = "Diff with Previous Commit" },
    { "<leader>gdc", git.diff_with_commit, desc = "Diff with Commit" },
    { "<leader>gdt", git.diff_two_commits, desc = "Diff Two Commits" },
    { "<leader>gdr", git.diff_with_remote_branch, desc = "Diff with Remote Branch" },
    { "<leader>gdf", git.diff_current_file_head, desc = "Diff File (Last Commit)" },
    { "<leader>gda", git.diff_current_file_commit, desc = "Diff File (Any Commit)" },
    { "<leader>gdd", "<cmd>DiffviewClose<cr>", desc = "Close Diff View" },
    { "<leader>gds", git.diff_staged, desc = "Diff Staged Changes" },

    -- Hunk operations
    { "<leader>gh", group = "🔄 Hunk" },
    { "<leader>ghp", git.preview_hunk, desc = "Preview Hunk" },
    { "<leader>ghr", git.reset_hunk, desc = "Reset Hunk" },
    { "<leader>ghR", git.reset_buffer, desc = "Reset Buffer" },
    { "<leader>ghs", git.stage_hunk, desc = "Stage Hunk" },
    { "<leader>ghS", git.stage_buffer, desc = "Stage Buffer" },
    { "<leader>ghu", git.undo_stage_hunk, desc = "Undo Stage Hunk" },
    { "<leader>ghn", git.next_hunk, desc = "Next Hunk" },
    { "<leader>ghN", git.prev_hunk, desc = "Previous Hunk" },
    { "<leader>ghv", git.view_hunk_diff, desc = "View Hunk Diff" },
    { "<leader>gha", git.stage_all_hunks, desc = "Stage All Hunks" },

    -- Log/History operations
    { "<leader>gl", group = "📜 Log/History" },
    { "<leader>gll", git.interactive_log, desc = "Interactive Git Log" },
    { "<leader>glf", git.enhanced_file_history, desc = "File History (Enhanced)" },
    { "<leader>glc", git.current_file_history, desc = "Current File History" },
    { "<leader>glb", git.branch_history, desc = "Branch History" },
    { "<leader>gla", git.author_log, desc = "Author Log" },
    { "<leader>gld", git.date_range_log, desc = "Date Range Log" },
    { "<leader>glg", git.graph_log, desc = "Graph Log" },
    { "<leader>gls", git.search_commits, desc = "Search Commits" },

    -- Stash operations
    { "<leader>gz", group = "📦 Stash" },
    { "<leader>gzl", git.stash_list, desc = "List Stashes (Interactive)" },
    { "<leader>gzs", git.quick_stash, desc = "Quick Stash" },
    { "<leader>gza", git.stash_apply, desc = "Apply Stash (Interactive)" },
    { "<leader>gzp", git.stash_pop, desc = "Pop Stash (Interactive)" },
    { "<leader>gzd", git.stash_drop, desc = "Drop Stash (Interactive)" },
    { "<leader>gzc", git.stash_clear, desc = "Clear All Stashes" },
    { "<leader>gzv", git.stash_view, desc = "View Stash Content" },

    -- Quick Actions
    { "<leader>gx", group = "⚡ Quick Actions" },
    { "<leader>gxc", git.smart_commit, desc = "Smart Commit (Stage + Commit)" },
    { "<leader>gxa", git.amend_commit, desc = "Amend Last Commit" },
    { "<leader>gxp", git.push_with_options, desc = "Push with Options" },
    { "<leader>gxP", git.pull_with_options, desc = "Pull with Options" },
    { "<leader>gxf", git.fetch_all, desc = "Fetch All Remotes" },
    { "<leader>gxr", git.interactive_rebase, desc = "Interactive Rebase" },
    { "<leader>gxy", git.cherry_pick, desc = "Cherry-pick (Interactive)" },
    { "<leader>gxu", git.undo_commit, desc = "Undo Last Commit" },

    -- Remote operations
    { "<leader>gw", group = "🌐 Remote" },
    { "<leader>gwl", git.remote_list, desc = "List Remotes" },
    { "<leader>gwa", git.remote_add, desc = "Add Remote" },
    { "<leader>gwr", git.remote_remove, desc = "Remove Remote" },
    { "<leader>gwp", git.remote_prune, desc = "Prune Remote Branches" },
    { "<leader>gwf", git.remote_fetch, desc = "Fetch from Remote" },
    { "<leader>gwt", git.remote_track, desc = "Track Remote Branch" },

    -- Blame operations
    { "<leader>gB", git.blame_line_full, desc = "Blame Line (Full)" },
    { "<leader>gt", git.toggle_blame, desc = "Toggle Line Blame" },

    -- Telescope Git operations
    { "<leader>gc", git.git_commits, desc = "Git Commits" },
    { "<leader>gC", git.git_bcommits, desc = "Buffer Commits" },

    -- Search operations
    { "<leader>s", group = "🔍 Search" },
    {
        "<leader>sf",
        function()
            local custom = _G.telescope_custom
            if custom and custom.find_files_smart then
                custom.find_files_smart()
            else
                require("telescope.builtin").find_files()
            end
        end,
        desc = "Search Files (Smart)"
    },
    { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search Grep" },
    {
        "<leader>sw",
        function()
            local custom = _G.telescope_custom
            if custom and custom.grep_string_visual then
                custom.grep_string_visual()
            else
                require("telescope.builtin").grep_string()
            end
        end,
        desc = "Search Word Under Cursor"
    },
    { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Search Buffers" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search Help" },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Search Recent" },
    { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Search Colorschemes" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Search Keymaps" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Search Marks" },
    { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Search Jumplist" },
    { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Search Quickfix" },
    { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Search Location List" },

    -- Debug operations
    { "<leader>d", group = "🐛 Debug" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Conditional Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle UI" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },

    -- Debug function keys for quick access
    { "<F8>", function() require("dap").continue() end, desc = "Debug: Continue" },
    { "<F9>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
    { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
    { "<F11>", function() require("dap").step_out() end, desc = "Debug: Step Out" },

    -- Colorscheme
    { "<leader>c", group = "🎨 Colorscheme" },
    { "<leader>cs", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "Select Colorscheme" },

    -- Quick actions
    { "<leader>q", group = "⚡ Quick" },
    { "<leader>qq", "<cmd>qa<cr>", desc = "Quit All" },
    { "<leader>qw", "<cmd>wqa<cr>", desc = "Save and Quit All" },
    { "<leader>qf", "<cmd>qa!<cr>", desc = "Force Quit All" },

    -- Utility
    { "<leader>u", group = "🔧 Utility" },
    { "<leader>ul", "<cmd>Lazy<cr>", desc = "Lazy Plugin Manager" },
    { "<leader>um", "<cmd>Mason<cr>", desc = "Mason LSP Manager" },
    { "<leader>uc", "<cmd>e $MYVIMRC<cr>", desc = "Edit Config" },
    { "<leader>ur", "<cmd>source $MYVIMRC<cr>", desc = "Reload Config" },
    { "<leader>ui", "<cmd>Lazy install<cr>", desc = "Install Plugins" },
    { "<leader>us", "<cmd>Lazy sync<cr>", desc = "Sync Plugins" },
    { "<leader>uu", "<cmd>Lazy update<cr>", desc = "Update Plugins" },
    { "<leader>up", "<cmd>Lazy profile<cr>", desc = "Profile Plugins" },

    -- Sessions
    { "<leader>S", group = "💾 Session" },
    { "<leader>Ss", "<cmd>SessionSave<cr>", desc = "Save Session" },
    { "<leader>Sr", "<cmd>SessionRestore<cr>", desc = "Restore Session" },
    { "<leader>Sd", "<cmd>SessionDelete<cr>", desc = "Delete Session" },

    -- Toggle options
    { "<leader>o", group = "⚙️ Options" },
    { "<leader>on", "<cmd>set number!<cr>", desc = "Toggle Line Numbers" },
    { "<leader>or", "<cmd>set relativenumber!<cr>", desc = "Toggle Relative Numbers" },
    { "<leader>ow", "<cmd>set wrap!<cr>", desc = "Toggle Line Wrap" },
    { "<leader>os", "<cmd>set spell!<cr>", desc = "Toggle Spell Check" },
    { "<leader>ol", "<cmd>set list!<cr>", desc = "Toggle Listchars" },
    { "<leader>oc", "<cmd>set cursorline!<cr>", desc = "Toggle Cursor Line" },
    { "<leader>oh", "<cmd>set hlsearch!<cr>", desc = "Toggle Search Highlight" },
    { "<leader>of", "<cmd>set foldenable!<cr>", desc = "Toggle Folding" },

    -- Zen mode
    { "<leader>z", group = "🧘 Zen" },
    { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    { "<leader>zt", "<cmd>Twilight<cr>", desc = "Twilight" },

    -- Terminal & External Tools
    { "<leader>t", group = "💻 Terminal" },

    -- Basic Terminal Operations
    { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<cr>", desc = "Horizontal Terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Vertical Terminal" },
    { "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", desc = "Toggle All Terminals" },

    -- Multiple Terminal Management
    { "<leader>tm", group = "🔢 Multiple Terminals" },
    { "<leader>tm1", "<cmd>1ToggleTerm<cr>", desc = "Terminal 1" },
    { "<leader>tm2", "<cmd>2ToggleTerm<cr>", desc = "Terminal 2" },
    { "<leader>tm3", "<cmd>3ToggleTerm<cr>", desc = "Terminal 3" },
    { "<leader>tm4", "<cmd>4ToggleTerm<cr>", desc = "Terminal 4" },
    { "<leader>tms", "<cmd>TermSelect<cr>", desc = "Select Terminal" },

    -- System Monitoring Tools
    { "<leader>ts", group = "📊 System Tools" },
    { "<leader>tsh", terminal.htop, desc = "Htop" },
    { "<leader>tsb", terminal.btop, desc = "Btop" },
    { "<leader>tsd", terminal.ncdu, desc = "Disk Usage (ncdu)" },

    -- Development Tools
    { "<leader>td", group = "🛠️ Dev Tools" },
    { "<leader>tdp", terminal.python_repl, desc = "Python REPL" },
    { "<leader>tdb", terminal.bpython, desc = "Bpython (Enhanced Python)" },

    -- Enhanced Float Terminal (moved from tF to tf)
    { "<leader>tf", terminal.enhanced_float, desc = "Enhanced Float Terminal" },

    -- Custom Command (moved from tcc to tc)
    { "<leader>tc", terminal.custom_command, desc = "Custom Command" },

    -- File/Text Processing Utilities
    { "<leader>tu", group = "🔧 Utilities" },
    { "<leader>tuj", terminal.jq, desc = "Jq (JSON Processor)" },
    { "<leader>tuy", terminal.yq, desc = "Yq (YAML Processor)" },
    { "<leader>tux", terminal.xsv, desc = "Xsv (CSV Toolkit)" },
    { "<leader>tuf", terminal.fzf, desc = "Fzf (Fuzzy Finder)" },
    { "<leader>tur", terminal.ripgrep, desc = "Ripgrep" },
    { "<leader>tub", terminal.bat, desc = "Bat (Enhanced Cat)" },

    -- Network Tools
    { "<leader>tw", group = "🌐 Network Tools" },
    { "<leader>twc", terminal.curl, desc = "Curl" },
    { "<leader>twh", terminal.httpie, desc = "HTTPie" },
    { "<leader>twn", terminal.nmap, desc = "Nmap" },
    { "<leader>twp", terminal.ping, desc = "Ping" },
    { "<leader>twt", terminal.traceroute, desc = "Traceroute" },

    -- Window management with Ctrl
    { "<C-h>", "<C-w>h", desc = "Go to Left Window", mode = { "n", "t" } },
    { "<C-j>", "<C-w>j", desc = "Go to Lower Window", mode = { "n", "t" } },
    { "<C-k>", "<C-w>k", desc = "Go to Upper Window", mode = { "n", "t" } },
    { "<C-l>", "<C-w>l", desc = "Go to Right Window", mode = { "n", "t" } },

    -- Better window resizing
    { "<C-Up>", "<cmd>resize +2<cr>", desc = "Increase Window Height" },
    { "<C-Down>", "<cmd>resize -2<cr>", desc = "Decrease Window Height" },
    { "<C-Left>", "<cmd>vertical resize -2<cr>", desc = "Decrease Window Width" },
    { "<C-Right>", "<cmd>vertical resize +2<cr>", desc = "Increase Window Width" },

    -- Tab navigation
    { "<Tab>", "<cmd>bnext<cr>", desc = "Next Buffer" },
    { "<S-Tab>", "<cmd>bprev<cr>", desc = "Previous Buffer" },

    -- Better escape for terminal mode
    { "<Esc><Esc>", "<C-\\><C-n>", desc = "Exit Terminal Mode", mode = "t" },

    -- Clear search highlighting and redraw
    { "<Esc>", "<cmd>nohlsearch<cr><cmd>redraw<cr>", desc = "Clear Search & Redraw" },
    { "<leader>h", "<cmd>nohlsearch<cr>", desc = "Clear Search Highlight" },

    -- Better scrolling (keep cursor centered)
    { "<C-d>", navigation.smart_scroll_down, desc = "Smart Scroll Down & Center" },
    { "<C-u>", navigation.smart_scroll_up, desc = "Smart Scroll Up & Center" },

    -- Quickfix navigation
    { "<M-j>", "<cmd>cnext<cr>", desc = "Next Quickfix Item" },
    { "<M-k>", "<cmd>cprev<cr>", desc = "Previous Quickfix Item" },

    -- Quick save
    { "<C-s>", "<cmd>w<cr>", desc = "Save File", mode = { "n", "i", "v" } },

    -- Direct buffer access by number
    { "<leader>1", function() navigation.goto_buffer(1) end, desc = "Buffer 1" },
    { "<leader>2", function() navigation.goto_buffer(2) end, desc = "Buffer 2" },
    { "<leader>3", function() navigation.goto_buffer(3) end, desc = "Buffer 3" },
    { "<leader>4", function() navigation.goto_buffer(4) end, desc = "Buffer 4" },
    { "<leader>5", function() navigation.goto_buffer(5) end, desc = "Buffer 5" },
    { "<leader>6", function() navigation.goto_buffer(6) end, desc = "Buffer 6" },
    { "<leader>7", function() navigation.goto_buffer(7) end, desc = "Buffer 7" },
    { "<leader>8", function() navigation.goto_buffer(8) end, desc = "Buffer 8" },
    { "<leader>9", function() navigation.goto_buffer(9) end, desc = "Buffer 9" },
    { "<leader>0", function() navigation.goto_last_buffer() end, desc = "Last Buffer" },

    -- Quick diagnostic navigation (no leader key needed - global shortcuts)
    { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
    { "[d", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
    { "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Next Error" },
    { "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Previous Error" },
    { "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, desc = "Next Warning" },
    { "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, desc = "Previous Warning" },

    -- Enhanced search navigation with centering
    { "n", "nzzzv", desc = "Next Search (Centered)" },
    { "N", "Nzzzv", desc = "Previous Search (Centered)" },
    { "*", "*zzzv", desc = "Search Word Forward (Centered)" },
    { "#", "#zzzv", desc = "Search Word Backward (Centered)" },
    { "g*", "g*zzzv", desc = "Search Partial Forward (Centered)" },
    { "g#", "g#zzzv", desc = "Search Partial Backward (Centered)" },

    -- Jump navigation with centering
    { "<C-o>", "<C-o>zz", desc = "Jump Back (Centered)" },
    { "<C-i>", "<C-i>zz", desc = "Jump Forward (Centered)" },
    { "gg", "ggzz", desc = "Go to Top (Centered)" },
    { "G", "Gzz", desc = "Go to Bottom (Centered)" },

    -- Enhanced paragraph/section navigation
    { "{", "{zz", desc = "Previous Paragraph (Centered)" },
    { "}", "}zz", desc = "Next Paragraph (Centered)" },
    { "[[", "[[zz", desc = "Previous Section (Centered)" },
    { "]]", "]]zz", desc = "Next Section (Centered)" },

    -- View control (screen positioning)
    { "<leader>v", group = "👁️ View" },
    { "<leader>vt", "zt", desc = "View: Scroll to Top" },
    { "<leader>vc", "zz", desc = "View: Center Screen" },
    { "<leader>vb", "zb", desc = "View: Scroll to Bottom" },

    -- Enhanced LSP navigation (global shortcuts for frequently used actions)
    { "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
    { "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
    { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
    { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
    { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definitions" },
    { "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
})

-- Visual mode mappings
wk.add({
    mode = { "v" },
    { "<leader>g", group = "🔀 Git" },
    { "<leader>gh", group = "🔄 Hunk" },
    { "<leader>ghs", git.stage_hunk, desc = "Stage Hunk" },
    { "<leader>ghr", git.reset_hunk, desc = "Reset Hunk" },

    -- Code actions in visual mode
    { "<leader>l", group = "🔧 LSP" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Actions" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format({ range = true })<cr>", desc = "Format Selection" },

    -- Search selected text
    { "<leader>s", group = "🔍 Search" },
    { "<leader>sg", 'y<cmd>Telescope live_grep default_text=<C-r>"<cr>', desc = "Search Selection" },

    -- Better indenting (keeps selection)
    { "<", "<gv", desc = "Unindent" },
    { ">", ">gv", desc = "Indent" },

    -- Move selected lines
    { "J", ":m '>+1<cr>gv=gv", desc = "Move Selection Down" },
    { "K", ":m '<-2<cr>gv=gv", desc = "Move Selection Up" },
})

-- Insert mode mappings
wk.add({
    mode = { "i" },
    -- Quick escape alternatives
    { "jk",    "<Esc>",                    desc = "Escape" },
    { "kj",    "<Esc>",                    desc = "Escape" },

    -- Navigation in insert mode
    { "<C-h>", "<Left>",                   desc = "Move Left" },
    { "<C-j>", "<Down>",                   desc = "Move Down" },
    { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature Help" },
    { "<C-l>", "<Right>",                  desc = "Move Right" },

    -- Line operations
    { "<C-a>", "<Home>",                   desc = "Go to Beginning of Line" },
    { "<C-e>", "<End>",                    desc = "Go to End of Line" },
    { "<C-d>", "<Del>",                    desc = "Delete Character" },
})
