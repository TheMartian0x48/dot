-- StickyNotes: Persistent floating notes buffer
-- Provides a floating window for quick notes that persists across sessions

local M = {}

-- Configuration
local config = {
    -- File to store notes (using .md extension for proper markdown recognition)
    notes_file = vim.fn.stdpath("data") .. "/stickynotes.md",
    -- Window configuration
    window = {
        width = 60,
        height = 20,
        row = 5,
        col = 10,
        border = "rounded",
        title = " 📝 Sticky Notes ",
        title_pos = "center",
    },
    -- Auto-save settings
    auto_save = true,
    save_on_focus_lost = true,
}

-- State management
local state = {
    buf = nil,
    win = nil,
    is_open = false,
}

-- Create or get the notes buffer
local function get_or_create_buffer()
    if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
        return state.buf
    end

    -- Create new buffer
    state.buf = vim.api.nvim_create_buf(false, true)

    -- Set buffer options
    vim.api.nvim_buf_set_option(state.buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(state.buf, 'swapfile', false)
    vim.api.nvim_buf_set_option(state.buf, 'filetype', 'markdown')
    vim.api.nvim_buf_set_option(state.buf, 'bufhidden', 'hide')
    vim.api.nvim_buf_set_name(state.buf, 'StickyNotes')

    -- Markdown-specific buffer options
    vim.api.nvim_buf_set_option(state.buf, 'conceallevel', 2)     -- Hide markdown syntax when not on that line
    vim.api.nvim_buf_set_option(state.buf, 'concealcursor', 'nc') -- Conceal in normal and command mode
    vim.api.nvim_buf_set_option(state.buf, 'textwidth', 80)       -- Good width for markdown
    vim.api.nvim_buf_set_option(state.buf, 'spell', true)         -- Enable spellcheck for notes

    -- Load existing notes
    M.load_notes()

    -- Set up auto-save
    if config.auto_save then
        vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
            buffer = state.buf,
            callback = function()
                vim.defer_fn(M.save_notes, 1000) -- Debounced save
            end,
        })
    end

    if config.save_on_focus_lost then
        vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
            buffer = state.buf,
            callback = M.save_notes,
        })
    end

    return state.buf
end

-- Calculate window position (centered)
local function get_window_config()
    local screen_w = vim.o.columns
    local screen_h = vim.o.lines
    local window_w = config.window.width
    local window_h = config.window.height

    -- Center the window
    local row = math.ceil((screen_h - window_h) / 2 - 1)
    local col = math.ceil((screen_w - window_w) / 2)

    return {
        relative = "editor",
        width = window_w,
        height = window_h,
        row = row,
        col = col,
        border = config.window.border,
        title = config.window.title,
        title_pos = config.window.title_pos,
        style = "minimal",
    }
end

-- Open the floating window
function M.open()
    if state.is_open and state.win and vim.api.nvim_win_is_valid(state.win) then
        -- Focus existing window
        vim.api.nvim_set_current_win(state.win)
        return
    end

    local buf = get_or_create_buffer()
    local win_config = get_window_config()

    state.win = vim.api.nvim_open_win(buf, true, win_config)
    state.is_open = true

    -- Set window options for better markdown editing
    vim.api.nvim_win_set_option(state.win, 'wrap', true)
    vim.api.nvim_win_set_option(state.win, 'cursorline', true)
    vim.api.nvim_win_set_option(state.win, 'number', false)
    vim.api.nvim_win_set_option(state.win, 'relativenumber', false)
    vim.api.nvim_win_set_option(state.win, 'linebreak', true)   -- Break lines at word boundaries
    vim.api.nvim_win_set_option(state.win, 'breakindent', true) -- Preserve indentation in wrapped lines
    vim.api.nvim_win_set_option(state.win, 'winblend', 0)       -- Remove transparency for better readability

    -- Set up window-specific keymaps
    local opts = { buffer = buf, silent = true }
    vim.keymap.set('n', '<leader>sn', M.close, opts)

    -- Markdown-specific keybindings
    vim.keymap.set('n', '<leader>mb', 'ciw**<C-r>"**<Esc>', vim.tbl_extend('force', opts, { desc = 'Bold word' }))
    vim.keymap.set('v', '<leader>mb', 'c**<C-r>"**<Esc>', vim.tbl_extend('force', opts, { desc = 'Bold selection' }))
    vim.keymap.set('n', '<leader>mi', 'ciw*<C-r>"*<Esc>', vim.tbl_extend('force', opts, { desc = 'Italic word' }))
    vim.keymap.set('v', '<leader>mi', 'c*<C-r>"*<Esc>', vim.tbl_extend('force', opts, { desc = 'Italic selection' }))
    vim.keymap.set('n', '<leader>mc', 'ciw`<C-r>"`<Esc>', vim.tbl_extend('force', opts, { desc = 'Code word' }))
    vim.keymap.set('v', '<leader>mc', 'c`<C-r>"`<Esc>', vim.tbl_extend('force', opts, { desc = 'Code selection' }))
    vim.keymap.set('n', '<leader>ml', 'I- [ ] <Esc>', vim.tbl_extend('force', opts, { desc = 'Add checkbox' }))
    vim.keymap.set('n', '<leader>mx', function()
        local line = vim.api.nvim_get_current_line()
        if line:match('%- %[ %]') then
            vim.api.nvim_set_current_line(line:gsub('%- %[ %]', '- [x]'))
        elseif line:match('%- %[x%]') then
            vim.api.nvim_set_current_line(line:gsub('%- %[x%]', '- [ ]'))
        end
    end, vim.tbl_extend('force', opts, { desc = 'Toggle checkbox' }))

    -- Auto-close on window leave (optional)
    vim.api.nvim_create_autocmd("WinLeave", {
        buffer = buf,
        once = true,
        callback = function()
            vim.defer_fn(function()
                if state.is_open and state.win and vim.api.nvim_win_is_valid(state.win) then
                    -- Only close if we're not in the sticky notes window
                    local current_win = vim.api.nvim_get_current_win()
                    if current_win ~= state.win then
                        M.close()
                    end
                end
            end, 100)
        end,
    })

    -- Ensure solid background for readability
    vim.api.nvim_win_call(state.win, function()
        -- Set window-local highlight to ensure solid background
        vim.cmd([[
            highlight! link StickyNotesNormal Normal
            highlight! link StickyNotesBorder FloatBorder
            setlocal winhighlight=Normal:StickyNotesNormal,FloatBorder:StickyNotesBorder
        ]])
    end)

    -- Show helpful message
    vim.notify("📝 Sticky Notes opened! Press <Esc> or 'q' to close", vim.log.levels.INFO, { title = "StickyNotes" })
end

-- Close the floating window
function M.close()
    if state.win and vim.api.nvim_win_is_valid(state.win) then
        M.save_notes() -- Save before closing
        vim.api.nvim_win_close(state.win, true)
        state.win = nil
        state.is_open = false
    end
end

-- Toggle the floating window
function M.toggle()
    if state.is_open and state.win and vim.api.nvim_win_is_valid(state.win) then
        M.close()
    else
        M.open()
    end
end

-- Save notes to file
function M.save_notes()
    if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
        return
    end

    local lines = vim.api.nvim_buf_get_lines(state.buf, 0, -1, false)
    local content = table.concat(lines, '\n')

    -- Ensure directory exists
    local notes_dir = vim.fn.fnamemodify(config.notes_file, ':h')
    vim.fn.mkdir(notes_dir, 'p')

    -- Write to file
    local file = io.open(config.notes_file, 'w')
    if file then
        file:write(content)
        file:close()
    else
        vim.notify("Failed to save sticky notes", vim.log.levels.ERROR, { title = "StickyNotes" })
    end
end

-- Load notes from file
function M.load_notes()
    if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
        return
    end

    local file = io.open(config.notes_file, 'r')
    if file then
        local content = file:read('*all')
        file:close()

        if content and content ~= '' then
            local lines = vim.split(content, '\n')
            vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
        else
            -- Set default content for new notes
            local default_content = {
                "# 📝 Sticky Notes",
                "",
                "Welcome to your **persistent markdown notes**!",
                "",
                "## Features",
                "- Auto-saves your notes as you type",
                "- Full markdown support with syntax highlighting",
                "- Spell checking enabled",
                "- Press `<Esc>` or `q` to close",
                "- Use `<leader>sn` to toggle from anywhere",
                "",
                "## Markdown Shortcuts (in notes window)",
                "- `<leader>mb` - **Bold** word/selection",
                "- `<leader>mi` - *Italic* word/selection",
                "- `<leader>mc` - `Code` word/selection",
                "- `<leader>ml` - Add checkbox",
                "- `<leader>mx` - Toggle checkbox",
                "",
                "## Quick Notes",
                "*Add your quick thoughts here...*",
                "",
                "## TODO",
                "- [ ] Example task",
                "- [x] Completed task",
                "",
                "## Ideas",
                "> Great ideas start here!",
                "",
                "---",
                "",
                "**Tip:** This file is saved as `stickynotes.md` in your Neovim data directory.",
            }
            vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, default_content)
        end
    else
        -- File doesn't exist, create with default content
        local default_content = {
            "# 📝 Sticky Notes",
            "",
            "Welcome to your **persistent markdown notes**!",
            "",
            "## Features",
            "- Auto-saves your notes as you type",
            "- Full markdown support with syntax highlighting",
            "- Spell checking enabled",
            "- Press `<Esc>` or `q` to close",
            "- Use `<leader>sn` to toggle from anywhere",
            "",
            "## Markdown Shortcuts (in notes window)",
            "- `<leader>mb` - **Bold** word/selection",
            "- `<leader>mi` - *Italic* word/selection",
            "- `<leader>mc` - `Code` word/selection",
            "- `<leader>ml` - Add checkbox",
            "- `<leader>mx` - Toggle checkbox",
            "",
            "## Quick Notes",
            "*Add your quick thoughts here...*",
            "",
            "## TODO",
            "- [ ] Example task",
            "- [x] Completed task",
            "",
            "## Ideas",
            "> Great ideas start here!",
            "",
            "---",
            "",
            "**Tip:** This file is saved as `stickynotes.md` in your Neovim data directory.",
        }
        vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, default_content)
        M.save_notes() -- Save the default content
    end
end

-- Clear all notes
function M.clear_notes()
    if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
        vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, {})
        M.save_notes()
        vim.notify("Sticky notes cleared!", vim.log.levels.INFO, { title = "StickyNotes" })
    end
end

-- Get notes file path (for external access)
function M.get_notes_file()
    return config.notes_file
end

-- Setup function
function M.setup(opts)
    config = vim.tbl_deep_extend('force', config, opts or {})

    -- Create custom highlight groups for sticky notes
    vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
            -- Get current background color
            local normal_bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Normal')), 'bg#')
            local normal_fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Normal')), 'fg#')

            -- Create a slightly different background for sticky notes
            -- If we have a dark theme, make it slightly lighter; if light theme, make it slightly darker
            local is_dark = vim.o.background == 'dark'

            -- Define custom highlight groups
            vim.api.nvim_set_hl(0, 'StickyNotesNormal', {
                bg = normal_bg, -- Use normal background to ensure it's opaque
                fg = normal_fg,
            })

            vim.api.nvim_set_hl(0, 'StickyNotesBorder', {
                fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Comment')), 'fg#'),
                bg = normal_bg, -- Match the background for consistent appearance
            })
        end,
    })

    -- Trigger the highlight setup for current colorscheme
    vim.cmd('doautocmd ColorScheme')

    -- Create global keymaps
    vim.keymap.set('n', '<leader>sn', M.toggle, { desc = 'Toggle Sticky Notes', silent = true })
    vim.keymap.set('n', '<leader>sc', M.clear_notes, { desc = 'Clear Sticky Notes', silent = true })

    -- Create user commands
    vim.api.nvim_create_user_command('StickyNotes', M.toggle, { desc = 'Toggle sticky notes' })
    vim.api.nvim_create_user_command('StickyNotesOpen', M.open, { desc = 'Open sticky notes' })
    vim.api.nvim_create_user_command('StickyNotesClose', M.close, { desc = 'Close sticky notes' })
    vim.api.nvim_create_user_command('StickyNotesClear', M.clear_notes, { desc = 'Clear sticky notes' })
    vim.api.nvim_create_user_command('StickyNotesFile', function()
        vim.notify("Notes file: " .. config.notes_file, vim.log.levels.INFO, { title = "StickyNotes" })
    end, { desc = 'Show notes file path' })

    -- Auto-save on VimLeave
    vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = M.save_notes,
    })
end

return M
