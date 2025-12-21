-- Enhanced Navigation for Neovim
-- This module contains improved navigation functions for better workflow

local M = {}

-- Go to a specific buffer by number
M.goto_buffer = function(num)
    local buffers = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
            table.insert(buffers, buf)
        end
    end

    if buffers[num] then
        vim.api.nvim_set_current_buf(buffers[num])
        vim.notify("Buffer " .. num, vim.log.levels.INFO)
    else
        vim.notify("Buffer " .. num .. " not available", vim.log.levels.WARN)
    end
end

-- Go to the last buffer in the list
M.goto_last_buffer = function()
    local buffers = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
            table.insert(buffers, buf)
        end
    end

    if #buffers > 0 then
        vim.api.nvim_set_current_buf(buffers[#buffers])
    end
end

-- Interactive buffer picker using Telescope
M.buffer_picker = function()
    require("telescope.builtin").buffers({
        sort_mru = true,
        ignore_current_buffer = true,
    })
end

-- Enhanced scrolling with automatic centering
M.smart_scroll_down = function()
    vim.cmd("normal! \\<C-d>zz")
end

M.smart_scroll_up = function()
    vim.cmd("normal! \\<C-u>zz")
end

-- Switch to alternate buffer
M.alternate_buffer = function()
    vim.cmd("buffer #")
end

-- Smart buffer closing that preserves window layout
M.smart_close_buffer = function()
    local buf_count = #vim.fn.getbufinfo({ buflisted = 1 })
    if buf_count > 1 then
        vim.cmd("bprevious")
        vim.cmd("bdelete #")
    else
        vim.cmd("enew")
        vim.cmd("bdelete #")
    end
end

-- Jump to a buffer by entering its number
M.jump_to_buffer_by_number = function()
    vim.ui.input({ prompt = "Buffer number: " }, function(input)
        local num = tonumber(input)
        if num then
            M.goto_buffer(num)
        end
    end)
end

-- Show recent buffers sorted by most recently used
M.recent_buffers = function()
    require("telescope.builtin").buffers({
        sort_mru = true,
        sort_lastused = true,
    })
end

return M
