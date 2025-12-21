-- Enhanced Lualine Configuration with Advanced Features
-- Custom components for better statusline functionality

local function current_buffer_number()
    return "󰓩 " .. vim.api.nvim_get_current_buf()
end

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local function current_working_dir()
    local cwd = vim.fn.getcwd()
    local home = os.getenv("HOME")
    if string.find(cwd, home, 1, true) then
        cwd = "~" .. string.sub(cwd, string.len(home) + 1)
    end
    return " " .. vim.fn.fnamemodify(cwd, ":t")
end

local function lsp_clients()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        return ""
    end

    local client_names = {}
    for _, client in ipairs(clients) do
        table.insert(client_names, client.name)
    end
    return "󰒋 " .. table.concat(client_names, ", ")
end

local function file_size()
    local size = vim.fn.getfsize(vim.fn.expand('%:p'))
    if size <= 0 then
        return ""
    end

    local suffixes = { 'B', 'KB', 'MB', 'GB' }
    local index = 1
    while size > 1024 and index < #suffixes do
        size = size / 1024
        index = index + 1
    end

    return string.format("%.1f%s", size, suffixes[index])
end

local function word_count()
    if vim.bo.filetype == "markdown" or vim.bo.filetype == "text" then
        local words = vim.fn.wordcount().words
        return " " .. words .. " words"
    end
    return ""
end

local function macro_recording()
    local recording = vim.fn.reg_recording()
    if recording ~= "" then
        return "󰑊 Recording @" .. recording
    end
    return ""
end

local function search_count()
    if vim.v.hlsearch == 0 then
        return ""
    end

    local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 500 })
    if not ok or result.incomplete == 1 or result.total == 0 then
        return ""
    end

    return string.format(" %d/%d", result.current, result.total)
end

local function get_session_name()
    local session = vim.v.this_session
    if session ~= "" then
        return " " .. vim.fn.fnamemodify(session, ":t:r")
    end
    return ""
end

local function indent_info()
    local expandtab = vim.bo.expandtab
    local shiftwidth = vim.bo.shiftwidth
    if expandtab then
        return "Spaces: " .. shiftwidth
    else
        return "Tabs: " .. vim.bo.tabstop
    end
end



require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "gruvbox", -- Changed back to gruvbox theme
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = { "dashboard", "alpha", "starter" },
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true, -- Global statusline
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {
            {
                "mode",
                separator = { left = "" },
                right_padding = 2,
                fmt = function(str)
                    return str:sub(1, 3)
                end
            }
        },
        lualine_b = {
            {
                "branch",
                icon = " ",                -- Added git branch icon
                color = { fg = "#fe8019" } -- Gruvbox orange
            },
            {
                "diff",
                source = diff_source,
                symbols = { added = " ", modified = " ", removed = " " },
                diff_color = {
                    added = { fg = "#b8bb26" },    -- Gruvbox green
                    modified = { fg = "#fabd2f" }, -- Gruvbox yellow
                    removed = { fg = "#fb4934" }   -- Gruvbox red
                }
            },
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " ", hint = " " },
                diagnostics_color = {
                    error = { fg = "#fb4934" }, -- Gruvbox red
                    warn = { fg = "#fabd2f" },  -- Gruvbox yellow
                    info = { fg = "#83a598" },  -- Gruvbox blue
                    hint = { fg = "#8ec07c" }   -- Gruvbox aqua
                }
            }
        },
        lualine_c = {
            {
                "filename",
                path = 1,                  -- Relative path
                symbols = { modified = " ", readonly = " ", unnamed = "󰎞" },
                color = { fg = "#ebdbb2" } -- Gruvbox light
            },
            {
                macro_recording,
                color = { fg = "#fe8019", gui = "bold" } -- Gruvbox orange
            },
            {
                search_count,
                color = { fg = "#d3869b" } -- Gruvbox purple
            },
            {
                get_session_name,
                color = { fg = "#83a598" } -- Gruvbox blue
            }
        },
        lualine_x = {
            {
                lsp_clients,
                color = { fg = "#83a598" } -- Gruvbox blue
            },
            {
                file_size,
                color = { fg = "#b8bb26" } -- Gruvbox green
            },
            {
                word_count,
                color = { fg = "#fabd2f" } -- Gruvbox yellow
            },
            {
                indent_info,
                color = { fg = "#d3869b" } -- Gruvbox purple
            },
            {
                "encoding",
                fmt = string.upper,
                color = { fg = "#8ec07c" } -- Gruvbox aqua
            },
            {
                "fileformat",
                symbols = {
                    unix = "LF",
                    dos = "CRLF",
                    mac = "CR"
                },
                color = { fg = "#8ec07c" } -- Gruvbox aqua
            },
            {
                "filetype",
                colored = true,
                icon_only = false,
                icon = { align = "right" }
            }
        },
        lualine_y = {
            {
                current_buffer_number,
                color = { fg = "#928374" } -- Gruvbox gray
            },
            {
                current_working_dir,
                color = { fg = "#928374" } -- Gruvbox gray
            }
        },
        lualine_z = {
            {
                "progress",
                separator = { right = "" },
                left_padding = 2
            },
            {
                "location",
                separator = { right = "" },
                left_padding = 0
            }
        }
    },
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" }
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {
        "neo-tree",
        "nvim-tree",
        "toggleterm",
        "fugitive",
        "oil",
        "trouble",
        "lazy"
    }
})
