-- Terminal functions for Neovim
-- This module contains all terminal-related functions used in keymappings

local M = {}

-- Helper function to create a terminal with common settings
local function create_terminal(cmd, direction, opts)
    local Terminal = require('toggleterm.terminal').Terminal
    local default_opts = {
        cmd = cmd,
        direction = direction or "float",
        size = opts and opts.size or 15,
        float_opts = opts and opts.float_opts or {
            border = "curved",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
        },
        on_open = opts and opts.on_open or function(term)
            vim.cmd("startinsert!")
            if direction == "float" then
                -- Better key mappings for both normal and terminal mode
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
                vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-q>", "<cmd>close<CR>", { noremap = true, silent = true })
            end
        end,
        on_exit = opts and opts.on_exit or function()
            vim.cmd("stopinsert")
        end,
        close_on_exit = opts and opts.close_on_exit,
    }
    return Terminal:new(default_opts)
end

-- Helper function specifically for interactive system tools
local function create_interactive_terminal(cmd, direction, opts)
    local Terminal = require('toggleterm.terminal').Terminal
    local default_opts = {
        cmd = cmd,
        direction = direction or "float",
        size = opts and opts.size or 15,
        float_opts = opts and opts.float_opts or {
            border = "curved",
            width = math.floor(vim.o.columns * 0.9),
            height = math.floor(vim.o.lines * 0.9),
        },
        on_open = function(term)
            vim.cmd("startinsert!")
            -- Enhanced key mappings for interactive applications
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-q>", "<cmd>close<CR>", { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<Esc>", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        on_exit = function()
            vim.cmd("stopinsert")
        end,
        close_on_exit = true,
    }
    return Terminal:new(default_opts)
end

-- System Monitoring Tools
--------------------

M.htop = function()
    local htop = create_interactive_terminal("htop", "float", {
        float_opts = {
            border = "curved",
            width = math.floor(vim.o.columns * 0.9),
            height = math.floor(vim.o.lines * 0.9),
        },
    })
    htop:toggle()
end

M.btop = function()
    local btop = create_interactive_terminal("btop", "float", {
        float_opts = {
            border = "curved",
            width = math.floor(vim.o.columns * 0.9),
            height = math.floor(vim.o.lines * 0.9),
        },
    })
    btop:toggle()
end

M.ncdu = function()
    local ncdu = create_interactive_terminal("ncdu", "float", {
        float_opts = {
            border = "curved",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
        },
    })
    ncdu:toggle()
end

-- Development Tools
-------------------

M.python_repl = function()
    local python = create_terminal("python3", "horizontal", {
        size = 15,
    })
    python:toggle()
end

M.bpython = function()
    local bpython = create_terminal("bpython", "horizontal", {
        size = 15,
    })
    bpython:toggle()
end

-- Enhanced Terminal Operations
------------------------------

M.enhanced_float = function()
    local float_term = create_terminal(nil, "float", {
        float_opts = {
            border = "curved",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
            winblend = 0,
            zindex = 50,
        },
    })
    float_term:toggle()
end

M.custom_command = function()
    vim.ui.input({ prompt = "Command: " }, function(cmd)
        if cmd then
            local quick_term = create_terminal(cmd, "float", {
                close_on_exit = false,
                float_opts = {
                    border = "curved",
                    width = math.floor(vim.o.columns * 0.8),
                    height = math.floor(vim.o.lines * 0.8),
                },
            })
            quick_term:toggle()
        end
    end)
end

-- File/Text Processing Utilities
--------------------------------

M.jq = function()
    local jq = create_terminal("jq", "horizontal", {
        size = 15,
    })
    jq:toggle()
end

M.yq = function()
    local yq = create_terminal("yq", "horizontal", {
        size = 15,
    })
    yq:toggle()
end

M.xsv = function()
    local xsv = create_terminal("xsv", "horizontal", {
        size = 15,
    })
    xsv:toggle()
end

M.fzf = function()
    local fzf = create_terminal("fzf", "float", {
        float_opts = {
            border = "curved",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
        },
    })
    fzf:toggle()
end

M.ripgrep = function()
    local rg = create_terminal("rg", "horizontal", {
        size = 15,
    })
    rg:toggle()
end

M.bat = function()
    local bat = create_terminal("bat", "horizontal", {
        size = 15,
    })
    bat:toggle()
end

-- Network Tools
---------------

M.curl = function()
    local curl = create_terminal("curl", "horizontal", {
        size = 15,
    })
    curl:toggle()
end

M.httpie = function()
    local httpie = create_terminal("http", "horizontal", {
        size = 15,
    })
    httpie:toggle()
end

M.nmap = function()
    local nmap = create_terminal("nmap", "horizontal", {
        size = 15,
    })
    nmap:toggle()
end

M.ping = function()
    local ping = create_terminal("ping", "horizontal", {
        size = 15,
    })
    ping:toggle()
end

M.traceroute = function()
    local traceroute = create_terminal("traceroute", "horizontal", {
        size = 15,
    })
    traceroute:toggle()
end

-- Return all terminal functions
return M
