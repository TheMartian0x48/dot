-- File Operations for Neovim
-- This module contains enhanced file operations functions

local M = {}

-- Helper function to get project root
M.get_project_root = function()
    -- Try to find git directory first
    local git_dir = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
    if git_dir ~= "" then
        return vim.fn.fnamemodify(git_dir, ":h")
    end

    -- Try to find common project files
    local project_markers = {
        "package.json",     -- Node.js
        "Cargo.toml",       -- Rust
        "go.mod",           -- Go
        "pom.xml",          -- Maven
        "build.gradle",     -- Gradle
        "Makefile",         -- Make
        "CMakeLists.txt",   -- CMake
        "setup.py",         -- Python
        "requirements.txt", -- Python
        "composer.json",    -- PHP
    }

    for _, marker in ipairs(project_markers) do
        local marker_path = vim.fn.findfile(marker, vim.fn.getcwd() .. ";")
        if marker_path ~= "" then
            return vim.fn.fnamemodify(marker_path, ":h")
        end
    end

    -- Fallback to current directory
    return vim.fn.getcwd()
end

-- Smart find files based on context
M.find_files = function()
    local opts = {}

    -- Check if we're in a git repo
    local is_git = vim.fn.finddir(".git", vim.fn.getcwd() .. ";") ~= ""

    if is_git then
        -- Use git_files for git repos
        require("telescope.builtin").git_files(opts)
    else
        -- Use find_files for non-git repos
        require("telescope.builtin").find_files(opts)
    end
end

-- Find files in specific directory
M.find_in_directory = function()
    vim.ui.input({ prompt = "Directory: ", default = "./" }, function(input)
        if input then
            require("telescope.builtin").find_files({
                prompt_title = "Find in " .. input,
                cwd = input,
            })
        end
    end)
end

-- Recent files with better filtering
M.recent_all = function()
    require("telescope.builtin").oldfiles({
        prompt_title = "All Recent Files",
    })
end

M.recent_project = function()
    require("telescope.builtin").oldfiles({
        prompt_title = "Project Recent Files",
        cwd_only = true,
    })
end

M.recent_session = function()
    -- Filter oldfiles to those accessed in current session
    local session_files = {}
    for _, file in ipairs(vim.v.oldfiles) do
        if vim.fn.filereadable(file) == 1 then
            table.insert(session_files, file)
        end
        if #session_files >= 100 then break end
    end

    require("telescope.builtin").oldfiles({
        prompt_title = "Session Recent Files",
        cwd_only = false,
        tiebreak = "index", -- Sort by recency
    })
end

M.recent_frequent = function()
    -- This would ideally track file access frequency in a cache file
    -- For now, we'll just use oldfiles with a different sort
    require("telescope.builtin").oldfiles({
        prompt_title = "Frequently Used Files",
        cwd_only = false,
        tiebreak = "index", -- Sort by recency for now
    })
end

M.recent_by_category = function()
    -- Group files by type/category
    local categories = {
        ["Code"] = { "%.lua$", "%.js$", "%.ts$", "%.py$", "%.go$", "%.rs$", "%.c$", "%.cpp$", "%.h$", "%.java$" },
        ["Config"] = { "%.json$", "%.yaml$", "%.yml$", "%.toml$", "%.ini$", "%.conf$" },
        ["Docs"] = { "%.md$", "%.txt$", "%.rst$", "%.org$", "%.wiki$" },
        ["Web"] = { "%.html$", "%.css$", "%.scss$", "%.jsx$", "%.tsx$" },
    }

    vim.ui.select(vim.tbl_keys(categories), {
        prompt = "Select category:",
    }, function(category)
        if not category then return end

        local patterns = categories[category]
        require("telescope.builtin").oldfiles({
            prompt_title = category .. " Files",
            file_ignore_patterns = {},
            file_include_patterns = patterns,
        })
    end)
end

M.recent_by_type = function()
    -- Get list of filetypes
    local filetypes = {}
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
        if ft and ft ~= "" then
            filetypes[ft] = true
        end
    end

    local ft_list = vim.tbl_keys(filetypes)
    table.sort(ft_list)

    vim.ui.select(ft_list, {
        prompt = "Select filetype:",
    }, function(filetype)
        if not filetype then return end

        require("telescope.builtin").oldfiles({
            prompt_title = filetype .. " Files",
            -- This would need a custom filter to match by filetype
        })
    end)
end

-- Project-specific file finding
M.project_root_files = function()
    local project_root = M.get_project_root()
    require("telescope.builtin").find_files({
        prompt_title = "Project Root Files",
        cwd = project_root,
    })
end

M.workspace_files = function()
    -- This would ideally use a workspace configuration
    -- For now, just use the parent directory of the project root
    local project_root = M.get_project_root()
    local workspace_root = vim.fn.fnamemodify(project_root, ":h")

    require("telescope.builtin").find_files({
        prompt_title = "Workspace Files",
        cwd = workspace_root,
    })
end

M.project_type_files = function()
    -- Detect project type based on files
    local project_type = "unknown"
    local type_markers = {
        ["node"] = { "package.json", "node_modules" },
        ["rust"] = { "Cargo.toml", "src/main.rs", "src/lib.rs" },
        ["go"] = { "go.mod", "go.sum" },
        ["python"] = { "requirements.txt", "setup.py", "pyproject.toml" },
        ["web"] = { "index.html", "styles.css", "script.js" },
    }

    for type, markers in pairs(type_markers) do
        for _, marker in ipairs(markers) do
            if vim.fn.findfile(marker, vim.fn.getcwd() .. ";") ~= "" or
                vim.fn.finddir(marker, vim.fn.getcwd() .. ";") ~= "" then
                project_type = type
                break
            end
        end
        if project_type ~= "unknown" then break end
    end

    -- File patterns based on project type
    local patterns = {
        ["node"] = { "*.js", "*.ts", "*.jsx", "*.tsx" },
        ["rust"] = { "*.rs" },
        ["go"] = { "*.go" },
        ["python"] = { "*.py" },
        ["web"] = { "*.html", "*.css", "*.js" },
        ["unknown"] = { "*" },
    }

    require("telescope.builtin").find_files({
        prompt_title = project_type .. " Files",
        find_command = { "fd", "--type", "f", "--glob", table.concat(patterns[project_type] or patterns["unknown"], " --glob ") },
    })
end

M.config_files = function()
    require("telescope.builtin").find_files({
        prompt_title = "Config Files",
        find_command = { "fd", "--type", "f", "--glob", "*.json --glob *.yaml --glob *.yml --glob *.toml --glob *.ini --glob *.conf" },
    })
end

M.ignored_files = function()
    require("telescope.builtin").find_files({
        prompt_title = "Ignored Files",
        find_command = { "fd", "--no-ignore", "--hidden", "--type", "f" },
        file_ignore_patterns = {},
    })
end

M.project_structure = function()
    -- Show project structure as a tree
    local Terminal = require('toggleterm.terminal').Terminal
    local term = Terminal:new({
        cmd = "find . -type d -not -path '*/\\.*' | sort | tree --fromfile",
        direction = "float",
        float_opts = {
            border = "curved",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
        },
    })
    term:toggle()
end

-- Search & Grep functions
M.grep_with_context = function()
    require("telescope.builtin").live_grep({
        prompt_title = "Grep with Context",
        vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case", "--context=3"
        },
    })
end

M.grep_by_type = function()
    local filetypes = {
        "lua", "javascript", "typescript", "python", "rust", "go", "java",
        "c", "cpp", "html", "css", "markdown", "json", "yaml", "toml"
    }

    vim.ui.select(filetypes, {
        prompt = "Select filetype to grep in:",
    }, function(filetype)
        if not filetype then return end

        require("telescope.builtin").live_grep({
            prompt_title = "Grep in " .. filetype .. " files",
            type_filter = filetype,
            glob_pattern = "*." .. filetype,
        })
    end)
end

M.grep_word = function()
    require("telescope.builtin").grep_string({
        prompt_title = "Grep Word Under Cursor",
        word_match = "-w",
        search = vim.fn.expand("<cword>"),
    })
end

M.grep_selection = function()
    -- Get visual selection
    local get_visual_selection = function()
        local s_start = vim.fn.getpos("'<")
        local s_end = vim.fn.getpos("'>")
        local n_lines = math.abs(s_end[2] - s_start[2]) + 1
        local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
        lines[1] = string.sub(lines[1], s_start[3], -1)
        if n_lines == 1 then
            lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
        else
            lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
        end
        return table.concat(lines, "\n")
    end

    local selection = get_visual_selection()
    require("telescope.builtin").grep_string({
        prompt_title = "Grep Selection",
        search = selection,
    })
end

M.grep_replace = function()
    vim.ui.input({ prompt = "Search pattern: " }, function(search_pattern)
        if not search_pattern or search_pattern == "" then return end

        vim.ui.input({ prompt = "Replace with: " }, function(replace_pattern)
            if replace_pattern == nil then return end

            -- First search for the pattern
            require("telescope.builtin").grep_string({
                prompt_title = "Find for Replace: " .. search_pattern .. " → " .. replace_pattern,
                search = search_pattern,
                use_regex = true,
                on_complete = {
                    function(picker)
                        -- After selection, perform the replacement
                        local selections = picker:get_multi_selection()
                        if #selections > 0 then
                            -- Implement replacement logic here
                            vim.notify("Would replace in " .. #selections .. " locations")
                        end
                    end,
                },
            })
        end)
    end)
end

M.search_history = function()
    -- This would ideally use a search history file
    -- For now, just show recent searches from current session
    require("telescope.builtin").resume({
        prompt_title = "Search History",
    })
end

-- File Creation functions
M.new_file = function()
    vim.ui.input({ prompt = "New file: ", completion = "file" }, function(input)
        if not input or input == "" then return end

        -- Create parent directories if needed
        local dir = vim.fn.fnamemodify(input, ":h")
        if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end

        -- Create and open the file
        vim.cmd("edit " .. input)
        vim.notify("Created new file: " .. input)
    end)
end

M.new_from_template = function()
    -- Define some basic templates
    local templates = {
        ["Python Script"] =
        "#!/usr/bin/env python3\n\ndef main():\n    pass\n\nif __name__ == \"__main__\":\n    main()\n",
        ["HTML File"] =
        "<!DOCTYPE html>\n<html>\n<head>\n    <meta charset=\"UTF-8\">\n    <title>Title</title>\n</head>\n<body>\n    \n</body>\n</html>\n",
        ["JavaScript File"] = "// JavaScript File\n\nfunction main() {\n    \n}\n\nmain();\n",
        ["Lua Module"] =
        "-- Lua Module\n\nlocal M = {}\n\nM.hello = function()\n    print(\"Hello, World!\")\nend\n\nreturn M\n",
        ["Markdown"] = "# Title\n\n## Section\n\nContent goes here.\n",
    }

    vim.ui.select(vim.tbl_keys(templates), {
        prompt = "Select template:",
    }, function(template_name)
        if not template_name then return end

        vim.ui.input({ prompt = "New file: ", completion = "file" }, function(input)
            if not input or input == "" then return end

            -- Create parent directories if needed
            local dir = vim.fn.fnamemodify(input, ":h")
            if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
                vim.fn.mkdir(dir, "p")
            end

            -- Create and open the file with template content
            vim.cmd("edit " .. input)
            vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(templates[template_name], "\n"))
            vim.notify("Created new file from template: " .. input)
        end)
    end)
end

M.new_with_snippet = function()
    vim.ui.input({ prompt = "New file: ", completion = "file" }, function(input)
        if not input or input == "" then return end

        -- Create parent directories if needed
        local dir = vim.fn.fnamemodify(input, ":h")
        if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end

        -- Create and open the file
        vim.cmd("edit " .. input)

        -- Try to trigger snippet expansion based on filetype
        local ext = vim.fn.fnamemodify(input, ":e")
        if ext ~= "" then
            vim.schedule(function()
                -- This would ideally trigger a snippet expansion
                vim.cmd("normal! i" .. ext .. "_snippet")
                vim.cmd("normal! o")
            end)
        end

        vim.notify("Created new file with snippet: " .. input)
    end)
end

M.new_project_file = function()
    -- Detect project structure
    local project_root = M.get_project_root()
    local project_type = "unknown"

    -- Check for common project structures
    local structures = {
        ["node"] = { "src/", "components/", "pages/", "utils/" },
        ["rust"] = { "src/", "tests/", "examples/" },
        ["go"] = { "cmd/", "pkg/", "internal/" },
        ["python"] = { "src/", "tests/", "docs/" },
    }

    for type, dirs in pairs(structures) do
        local match_count = 0
        for _, dir in ipairs(dirs) do
            if vim.fn.isdirectory(project_root .. "/" .. dir) == 1 then
                match_count = match_count + 1
            end
        end
        if match_count >= 2 then
            project_type = type
            break
        end
    end

    -- Get project directories
    local project_dirs = {}
    local handle = vim.fn.glob(project_root .. "/*", false, true)
    for _, path in ipairs(handle) do
        if vim.fn.isdirectory(path) == 1 then
            table.insert(project_dirs, vim.fn.fnamemodify(path, ":t") .. "/")
        end
    end

    -- Sort directories
    table.sort(project_dirs)

    vim.ui.select(project_dirs, {
        prompt = "Select project directory:",
    }, function(dir)
        if not dir then return end

        vim.ui.input({ prompt = "New file in " .. dir .. ": " }, function(filename)
            if not filename or filename == "" then return end

            local full_path = project_root .. "/" .. dir .. filename

            -- Create parent directories if needed
            local parent_dir = vim.fn.fnamemodify(full_path, ":h")
            if parent_dir ~= "" and vim.fn.isdirectory(parent_dir) == 0 then
                vim.fn.mkdir(parent_dir, "p")
            end

            -- Create and open the file
            vim.cmd("edit " .. full_path)
            vim.notify("Created new project file: " .. full_path)
        end)
    end)
end

M.new_directory = function()
    vim.ui.input({ prompt = "New directory: ", completion = "dir" }, function(input)
        if not input or input == "" then return end

        -- Create directory
        vim.fn.mkdir(input, "p")
        vim.notify("Created directory: " .. input)
    end)
end

M.copy_file = function()
    local current_file = vim.fn.expand("%:p")
    if current_file == "" then
        vim.notify("No file open", vim.log.levels.ERROR)
        return
    end

    vim.ui.input({ prompt = "Copy to: ", completion = "file", default = current_file .. ".copy" }, function(input)
        if not input or input == "" then return end

        -- Create parent directories if needed
        local dir = vim.fn.fnamemodify(input, ":h")
        if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end

        -- Copy file
        vim.fn.system("cp " .. vim.fn.shellescape(current_file) .. " " .. vim.fn.shellescape(input))
        vim.notify("Copied " .. current_file .. " to " .. input)

        -- Open the new file
        vim.cmd("edit " .. input)
    end)
end

M.rename_file = function()
    local current_file = vim.fn.expand("%:p")
    if current_file == "" then
        vim.notify("No file open", vim.log.levels.ERROR)
        return
    end

    vim.ui.input({ prompt = "Rename to: ", completion = "file", default = current_file }, function(input)
        if not input or input == "" or input == current_file then return end

        -- Create parent directories if needed
        local dir = vim.fn.fnamemodify(input, ":h")
        if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end

        -- Rename file
        vim.fn.rename(current_file, input)
        vim.notify("Renamed " .. current_file .. " to " .. input)

        -- Open the renamed file
        vim.cmd("edit " .. input)
    end)
end

-- File Operations functions
M.rename = M.rename_file -- Alias

M.delete_file = function()
    local current_file = vim.fn.expand("%:p")
    if current_file == "" then
        vim.notify("No file open", vim.log.levels.ERROR)
        return
    end

    vim.ui.select({ "Yes", "No" }, {
        prompt = "Delete " .. current_file .. "?",
    }, function(choice)
        if choice == "Yes" then
            vim.fn.delete(current_file)
            vim.notify("Deleted " .. current_file)
            vim.cmd("bdelete!")
        end
    end)
end

M.copy = M.copy_file -- Alias

M.move_file = function()
    local current_file = vim.fn.expand("%:p")
    if current_file == "" then
        vim.notify("No file open", vim.log.levels.ERROR)
        return
    end

    vim.ui.input({ prompt = "Move to: ", completion = "file", default = current_file }, function(input)
        if not input or input == "" or input == current_file then return end

        -- Create parent directories if needed
        local dir = vim.fn.fnamemodify(input, ":h")
        if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end

        -- Move file
        vim.fn.rename(current_file, input)
        vim.notify("Moved " .. current_file .. " to " .. input)

        -- Open the moved file
        vim.cmd("edit " .. input)
    end)
end

M.file_permissions = function()
    local current_file = vim.fn.expand("%:p")
    if current_file == "" then
        vim.notify("No file open", vim.log.levels.ERROR)
        return
    end

    -- Get current permissions
    local permissions = vim.fn.getfperm(current_file)

    vim.ui.input({ prompt = "Change permissions: ", default = permissions }, function(input)
        if not input or input == "" then return end

        -- Change permissions
        vim.fn.system("chmod " .. input .. " " .. vim.fn.shellescape(current_file))
        vim.notify("Changed permissions of " .. current_file .. " to " .. input)
    end)
end

M.file_info = function()
    local current_file = vim.fn.expand("%:p")
    if current_file == "" then
        vim.notify("No file open", vim.log.levels.ERROR)
        return
    end

    -- Get file info
    local info = {
        ["Path"] = current_file,
        ["Size"] = vim.fn.getfsize(current_file) .. " bytes",
        ["Modified"] = vim.fn.strftime("%Y-%m-%d %H:%M:%S", vim.fn.getftime(current_file)),
        ["Permissions"] = vim.fn.getfperm(current_file),
        ["Type"] = vim.bo.filetype,
        ["Lines"] = vim.fn.line("$"),
    }

    -- Display info in a floating window
    local lines = {}
    for k, v in pairs(info) do
        table.insert(lines, k .. ": " .. v)
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    local width = 60
    local height = #lines
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "rounded",
        title = "File Info",
        title_pos = "center",
    })

    -- Close on q
    vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
end

return M
