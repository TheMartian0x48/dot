-- ============================================================================
-- DAP (DEBUG ADAPTER PROTOCOL) CONFIGURATION
-- Comprehensive debugging setup for multiple languages
-- ============================================================================

local dap = require("dap")
local dapui = require("dapui")

-- ============================================================================
-- DAP UI SETUP
-- ============================================================================

dapui.setup({
    -- Enhanced UI configuration
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    expand_lines = vim.fn.has("nvim-0.7") == 1,
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.25 },
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 0.25,
            position = "bottom",
        },
    },
    controls = {
        enabled = true,
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
        },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        border = "rounded",
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil,
        max_value_lines = 100,
    }
})

-- ============================================================================
-- DAP UI AUTO-OPEN/CLOSE INTEGRATION
-- ============================================================================

-- Auto-open DAP UI when debugging starts
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

-- Auto-close DAP UI when debugging ends
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

-- Enhanced error handling
dap.listeners.after.event_initialized.dapui_config = function()
    vim.notify("Debugger attached", vim.log.levels.INFO)
end

dap.listeners.after.event_terminated.dapui_config = function()
    vim.notify("Debugging session terminated", vim.log.levels.INFO)
end


-- ============================================================================
-- GOLANG DEBUGGING CONFIGURATION
-- ============================================================================

-- Delve adapter configuration
dap.adapters.delve = {
    type = 'server',
    port = '${port}',
    executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}', '--log', '--log-output=dap' },
        detached = vim.fn.has("win32") == 0,
    },
    options = {
        initialize_timeout_sec = 20,
    }
}

-- Alternative remote delve adapter for remote debugging
dap.adapters.delve_remote = function(callback, config)
    if config.mode == 'remote' and config.request == 'attach' then
        callback({
            type = 'server',
            host = config.host or '127.0.0.1',
            port = config.port or '38697'
        })
    end
end

-- Go debugging configurations
dap.configurations.go = {
    -- Debug current file
    {
        type = "delve",
        name = "Debug Current File",
        request = "launch",
        program = "${file}",
        cwd = "${workspaceFolder}",
        args = {},
        buildFlags = "",
        env = {},
        showLog = false,
    },
    -- Debug with arguments
    {
        type = "delve",
        name = "Debug with Arguments",
        request = "launch",
        program = "${file}",
        cwd = "${workspaceFolder}",
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
        showLog = false,
    },
    -- Debug current package
    {
        type = "delve",
        name = "Debug Package",
        request = "launch",
        program = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        args = {},
        showLog = false,
    },
    -- Debug test file
    {
        type = "delve",
        name = "Debug Test File",
        request = "launch",
        mode = "test",
        program = "${file}",
        cwd = "${workspaceFolder}",
        args = {},
        showLog = false,
    },
    -- Debug specific test function
    {
        type = "delve",
        name = "Debug Test Function",
        request = "launch",
        mode = "test",
        program = "${file}",
        cwd = "${workspaceFolder}",
        args = function()
            local test_name = vim.fn.input("Test function name: ")
            if test_name == "" then
                return {}
            end
            return { "-test.run", "^" .. test_name .. "$" }
        end,
        showLog = false,
    },
    -- Debug test package
    {
        type = "delve",
        name = "Debug Test Package",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
        cwd = "${workspaceFolder}",
        args = {},
        showLog = false,
    },
    -- Attach to running process
    {
        type = "delve",
        name = "Attach to Process",
        request = "attach",
        mode = "local",
        processId = function()
            return tonumber(vim.fn.input("Process ID: "))
        end,
        cwd = "${workspaceFolder}",
        showLog = false,
    },
    -- Remote debugging
    {
        type = "delve_remote",
        name = "Remote Debug",
        request = "attach",
        mode = "remote",
        host = function()
            return vim.fn.input("Host: ", "127.0.0.1")
        end,
        port = function()
            return tonumber(vim.fn.input("Port: ", "38697"))
        end,
        cwd = "${workspaceFolder}",
        showLog = false,
    },
}

-- ============================================================================
-- C/C++/RUST DEBUGGING CONFIGURATION
-- ============================================================================

-- Check if codelldb is available via Mason
local function get_codelldb_path()
    local mason_registry_ok, mason_registry = pcall(require, "mason-registry")
    if mason_registry_ok and mason_registry.is_installed("codelldb") then
        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        return {
            adapter_path = extension_path .. "adapter/codelldb",
            liblldb_path = extension_path .. "lldb/lib/liblldb.dylib" -- macOS path
        }
    end
    return nil
end

-- CodeLLDB adapter configuration
local codelldb_paths = get_codelldb_path()
if codelldb_paths then
    dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
            command = codelldb_paths.adapter_path,
            args = { "--port", "${port}" },
        }
    }
else
    -- Fallback to manual codelldb setup
    dap.adapters.codelldb = {
        type = 'server',
        host = '127.0.0.1',
        port = 13000,
        executable = {
            command = 'codelldb',
            args = { "--port", "13000" },
        }
    }
end

-- C debugging configurations
dap.configurations.c = {
    {
        name = "Debug C Program",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
        runInTerminal = false,
        console = 'integratedTerminal',
    },
    {
        name = "Debug C Program (Build First)",
        type = "codelldb",
        request = "launch",
        program = function()
            -- Try to build first
            local file = vim.fn.expand('%:p')
            local dir = vim.fn.expand('%:p:h')
            local name = vim.fn.expand('%:t:r')
            local executable = dir .. '/' .. name

            -- Simple gcc build
            local build_cmd = string.format('gcc -g -o %s %s', executable, file)
            print("Building: " .. build_cmd)
            local result = vim.fn.system(build_cmd)
            if vim.v.shell_error ~= 0 then
                print("Build failed: " .. result)
                return nil
            end
            print("Build successful")
            return executable
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
        console = 'integratedTerminal',
    },
}

-- C++ debugging configurations (inherit from C)
dap.configurations.cpp = {
    {
        name = "Debug C++ Program",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
        runInTerminal = false,
        console = 'integratedTerminal',
    },
    {
        name = "Debug C++ Program (Build First)",
        type = "codelldb",
        request = "launch",
        program = function()
            -- Try to build first
            local file = vim.fn.expand('%:p')
            local dir = vim.fn.expand('%:p:h')
            local name = vim.fn.expand('%:t:r')
            local executable = dir .. '/' .. name

            -- Simple g++ build
            local build_cmd = string.format('g++ -g -std=c++17 -o %s %s', executable, file)
            print("Building: " .. build_cmd)
            local result = vim.fn.system(build_cmd)
            if vim.v.shell_error ~= 0 then
                print("Build failed: " .. result)
                return nil
            end
            print("Build successful")
            return executable
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
        console = 'integratedTerminal',
    },
}

-- Rust debugging configurations
dap.configurations.rust = {
    {
        name = "Debug Rust Program",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
        runInTerminal = false,
        console = 'integratedTerminal',
        sourceLanguages = { 'rust' }
    },
    {
        name = "Debug Rust Program (Cargo Build)",
        type = "codelldb",
        request = "launch",
        program = function()
            -- Build with cargo first
            print("Building with cargo...")
            local result = vim.fn.system('cargo build')
            if vim.v.shell_error ~= 0 then
                print("Cargo build failed: " .. result)
                return nil
            end
            print("Cargo build successful")

            -- Try to find the executable
            local cwd = vim.fn.getcwd()
            local project_name = vim.fn.fnamemodify(cwd, ':t')
            local executable = cwd .. '/target/debug/' .. project_name

            if vim.fn.filereadable(executable) == 1 then
                return executable
            else
                return vim.fn.input('Path to executable: ', cwd .. '/target/debug/', 'file')
            end
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
        console = 'integratedTerminal',
        sourceLanguages = { 'rust' }
    },
    {
        name = "Debug Rust Test",
        type = "codelldb",
        request = "launch",
        program = function()
            -- Build tests with cargo
            print("Building tests with cargo...")
            local result = vim.fn.system('cargo test --no-run --message-format=json')
            if vim.v.shell_error ~= 0 then
                print("Cargo test build failed: " .. result)
                return nil
            end

            -- This is a simplified approach; you might want to parse the JSON output
            -- to find the exact test executable
            return vim.fn.input('Path to test executable: ', vim.fn.getcwd() .. '/target/debug/deps/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
        console = 'integratedTerminal',
        sourceLanguages = { 'rust' }
    },
}

-- ============================================================================
-- DAP VIRTUAL TEXT INTEGRATION
-- ============================================================================

-- Enhanced virtual text for debugging
local dap_vt_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if dap_vt_ok then
    dap_virtual_text.setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        display_callback = function(variable, buf, stackframe, node, options)
            if options.virt_text_pos == 'inline' then
                return ' = ' .. variable.value
            else
                return variable.name .. ' = ' .. variable.value
            end
        end,
        virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil
    })
end

-- ============================================================================
-- ADDITIONAL DAP UTILITIES
-- ============================================================================

-- Custom function to set conditional breakpoints
local function set_conditional_breakpoint()
    local condition = vim.fn.input("Breakpoint condition: ")
    if condition and condition ~= "" then
        dap.set_breakpoint(condition)
    end
end

-- Custom function to set log point
local function set_log_point()
    local message = vim.fn.input("Log message: ")
    if message and message ~= "" then
        dap.set_breakpoint(nil, nil, message)
    end
end

-- Make functions available globally for keymaps
_G.dap_conditional_breakpoint = set_conditional_breakpoint
_G.dap_log_point = set_log_point

-- ============================================================================
-- DAP STATUS LINE INTEGRATION
-- ============================================================================

-- Function to get DAP status for statusline
local function dap_status()
    local status = dap.status()
    if status == "" then
        return ""
    end
    return "🐛 " .. status
end

-- Make it available globally for statusline plugins
_G.dap_status = dap_status
