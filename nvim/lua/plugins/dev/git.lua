-- Git functions for Neovim
-- This module contains all Git-related functions used in keymappings

local M = {}

-- Main Git interface
--------------------
M.open_neogit = function()
    vim.cmd('Neogit')
end

-- Diff operations
-------------------

-- Open diff view comparing current branch with selected branch
M.diff_with_branch = function()
    require('telescope.builtin').git_branches({
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                require('telescope.actions').close(prompt_bufnr)
                vim.cmd('DiffviewOpen ' .. selection.value .. '...HEAD')
            end)
            return true
        end
    })
end

-- Open diff view with previous commit
M.diff_with_prev_commit = function()
    vim.cmd('DiffviewOpen HEAD~1')
end

-- Open diff view with selected commit
M.diff_with_commit = function()
    require('telescope.builtin').git_commits({
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                require('telescope.actions').close(prompt_bufnr)
                vim.cmd('DiffviewOpen ' .. selection.value .. '^!')
            end)
            return true
        end
    })
end

-- Open diff view between two arbitrary commits
M.diff_two_commits = function()
    vim.ui.input({ prompt = "First commit: " }, function(commit1)
        if commit1 then
            vim.ui.input({ prompt = "Second commit: " }, function(commit2)
                if commit2 then
                    vim.cmd('DiffviewOpen ' .. commit1 .. '..' .. commit2)
                end
            end)
        end
    end)
end

-- Open diff view comparing with remote branch
M.diff_with_remote_branch = function()
    vim.ui.input({ prompt = "Compare branch (default: origin/main): " }, function(branch)
        branch = branch and branch ~= "" and branch or "origin/main"
        vim.cmd('DiffviewOpen ' .. branch .. '...HEAD')
    end)
end

-- File-specific diff operations
M.diff_current_file_head = function()
    local file = vim.fn.expand('%')
    if file == '' then
        vim.notify("No file open", vim.log.levels.WARN)
        return
    end
    vim.cmd('DiffviewOpen HEAD~1 -- ' .. file)
end

M.diff_current_file_commit = function()
    local file = vim.fn.expand('%')
    if file == '' then
        vim.notify("No file open", vim.log.levels.WARN)
        return
    end

    require('telescope.builtin').git_bcommits({
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                require('telescope.actions').close(prompt_bufnr)
                vim.cmd('DiffviewOpen ' .. selection.value .. ' -- ' .. file)
            end)
            return true
        end
    })
end

-- History operations
---------------------

-- Open file history for all files
M.file_history = function()
    vim.cmd('DiffviewFileHistory')
end

-- Open file history for current file
M.current_file_history = function()
    vim.cmd('DiffviewFileHistory %')
end

-- Blame operations
------------------
M.blame_line = function()
    vim.cmd('Gitsigns blame_line')
end

M.blame_line_full = function()
    vim.cmd('Gitsigns blame_line full=true')
end

M.toggle_blame = function()
    vim.cmd('Gitsigns toggle_current_line_blame')
end

-- Hunk operations
-----------------
M.preview_hunk = function()
    vim.cmd('Gitsigns preview_hunk')
end

M.reset_hunk = function()
    vim.cmd('Gitsigns reset_hunk')
end

M.reset_buffer = function()
    vim.cmd('Gitsigns reset_buffer')
end

M.stage_hunk = function()
    vim.cmd('Gitsigns stage_hunk')
end

M.stage_buffer = function()
    vim.cmd('Gitsigns stage_buffer')
end

M.undo_stage_hunk = function()
    vim.cmd('Gitsigns undo_stage_hunk')
end

M.next_hunk = function()
    vim.cmd('Gitsigns next_hunk')
end

M.prev_hunk = function()
    vim.cmd('Gitsigns prev_hunk')
end

-- Telescope Git operations
--------------------------
M.git_commits = function()
    require('telescope.builtin').git_commits()
end

M.git_bcommits = function()
    require('telescope.builtin').git_bcommits()
end

M.git_status = function()
    require('telescope.builtin').git_status()
end

-- Branch operations
--------------------

-- Interactive branch checkout
M.branch_checkout = function()
    require('telescope.builtin').git_branches({
        prompt_title = "Checkout Branch",
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                require('telescope.actions').close(prompt_bufnr)
                local branch = selection.value:gsub("^%s*", ""):gsub("%s*$", "")
                -- Remove origin/ prefix if present for remote branches
                if branch:match("^origin/") then
                    branch = branch:gsub("^origin/", "")
                end
                vim.cmd('Git checkout ' .. branch)
                vim.notify("Switched to branch: " .. branch, vim.log.levels.INFO)
            end)
            return true
        end
    })
end

-- Create new branch
M.branch_create = function()
    vim.ui.input({ prompt = "New branch name: " }, function(branch_name)
        if branch_name and branch_name ~= "" then
            -- Ask which branch to create from
            require('telescope.builtin').git_branches({
                prompt_title = "Create from branch",
                attach_mappings = function(_, map)
                    map('i', '<CR>', function(prompt_bufnr)
                        local selection = require('telescope.actions.state').get_selected_entry()
                        require('telescope.actions').close(prompt_bufnr)
                        local base_branch = selection.value:gsub("^%s*", ""):gsub("%s*$", "")
                        if base_branch:match("^origin/") then
                            base_branch = base_branch:gsub("^origin/", "")
                        end
                        vim.cmd('Git checkout -b ' .. branch_name .. ' ' .. base_branch)
                        vim.notify("Created and switched to branch: " .. branch_name, vim.log.levels.INFO)
                    end)
                    return true
                end
            })
        end
    end)
end

-- Delete branch interactively
M.branch_delete = function()
    require('telescope.builtin').git_branches({
        prompt_title = "Delete Branch",
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                require('telescope.actions').close(prompt_bufnr)
                local branch = selection.value:gsub("^%s*", ""):gsub("%s*$", "")

                -- Safety checks
                local current_branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
                if branch == current_branch then
                    vim.notify("Cannot delete current branch", vim.log.levels.ERROR)
                    return
                end
                if branch:match("main") or branch:match("master") or branch:match("develop") then
                    vim.notify("Cannot delete protected branch: " .. branch, vim.log.levels.ERROR)
                    return
                end

                vim.ui.select({ "Yes", "No" }, {
                    prompt = "Delete branch '" .. branch .. "'?",
                }, function(choice)
                    if choice == "Yes" then
                        vim.cmd('Git branch -d ' .. branch)
                        vim.notify("Deleted branch: " .. branch, vim.log.levels.INFO)
                    end
                end)
            end)
            return true
        end
    })
end

-- Rename current branch
M.branch_rename = function()
    local current_branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
    vim.ui.input({
        prompt = "Rename branch '" .. current_branch .. "' to: ",
        default = current_branch
    }, function(new_name)
        if new_name and new_name ~= "" and new_name ~= current_branch then
            vim.cmd('Git branch -m ' .. new_name)
            vim.notify("Renamed branch to: " .. new_name, vim.log.levels.INFO)
        end
    end)
end

-- Merge branch interactively
M.branch_merge = function()
    require('telescope.builtin').git_branches({
        prompt_title = "Merge Branch",
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                require('telescope.actions').close(prompt_bufnr)
                local branch = selection.value:gsub("^%s*", ""):gsub("%s*$", "")
                if branch:match("^origin/") then
                    branch = branch:gsub("^origin/", "")
                end

                vim.ui.select({ "Fast-forward", "No fast-forward", "Squash" }, {
                    prompt = "Merge type for '" .. branch .. "':",
                }, function(choice)
                    if choice == "Fast-forward" then
                        vim.cmd('Git merge --ff-only ' .. branch)
                    elseif choice == "No fast-forward" then
                        vim.cmd('Git merge --no-ff ' .. branch)
                    elseif choice == "Squash" then
                        vim.cmd('Git merge --squash ' .. branch)
                    end
                    if choice then
                        vim.notify("Merged branch: " .. branch, vim.log.levels.INFO)
                    end
                end)
            end)
            return true
        end
    })
end

-- List all branches
M.branch_list = function()
    require('telescope.builtin').git_branches({
        prompt_title = "All Branches",
        show_remote_tracking_branches = true,
    })
end

-- Push current branch
M.branch_push = function()
    local current_branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
    vim.ui.select({ "origin", "upstream", "other" }, {
        prompt = "Push '" .. current_branch .. "' to remote:",
    }, function(choice)
        if choice == "other" then
            vim.ui.input({ prompt = "Remote name: " }, function(remote)
                if remote and remote ~= "" then
                    vim.cmd('Git push ' .. remote .. ' ' .. current_branch)
                    vim.notify("Pushed to " .. remote .. "/" .. current_branch, vim.log.levels.INFO)
                end
            end)
        elseif choice then
            vim.cmd('Git push ' .. choice .. ' ' .. current_branch)
            vim.notify("Pushed to " .. choice .. "/" .. current_branch, vim.log.levels.INFO)
        end
    end)
end

-- Enhanced hunk operations
--------------------------

-- View hunk diff in popup
M.view_hunk_diff = function()
    require('gitsigns').preview_hunk()
end

-- Stage all hunks in buffer
M.stage_all_hunks = function()
    require('gitsigns').stage_buffer()
    vim.notify("Staged all hunks in buffer", vim.log.levels.INFO)
end

-- Diff staged changes
M.diff_staged = function()
    vim.cmd('DiffviewOpen --staged')
end

-- Log/History operations
------------------------

-- Interactive git log with actions
M.interactive_log = function()
    require('telescope.builtin').git_commits({
        prompt_title = "Git Log (Interactive)",
        attach_mappings = function(_, map)
            map('i', '<C-d>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                require('telescope.actions').close(prompt_bufnr)
                vim.cmd('DiffviewOpen ' .. selection.value .. '^!')
            end)
            map('i', '<C-y>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                vim.fn.setreg('+', selection.value)
                vim.notify("Copied commit hash: " .. selection.value, vim.log.levels.INFO)
            end)
            return true
        end
    })
end

-- Enhanced file history
M.enhanced_file_history = function()
    local file = vim.fn.expand('%')
    if file == '' then
        vim.cmd('DiffviewFileHistory')
    else
        vim.cmd('DiffviewFileHistory %')
    end
end

-- Branch history (current branch)
M.branch_history = function()
    local current_branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
    require('telescope.builtin').git_commits({
        prompt_title = "History: " .. current_branch,
        git_command = { "git", "log", "--oneline", "--graph", current_branch }
    })
end

-- Author log
M.author_log = function()
    vim.ui.input({ prompt = "Author name (or leave empty for all): " }, function(author)
        local git_cmd = { "git", "log", "--oneline" }
        if author and author ~= "" then
            table.insert(git_cmd, "--author=" .. author)
        end

        require('telescope.builtin').git_commits({
            prompt_title = author and "Commits by: " .. author or "All Authors",
            git_command = git_cmd
        })
    end)
end

-- Date range log
M.date_range_log = function()
    vim.ui.input({ prompt = "Since date (YYYY-MM-DD or '1 week ago'): " }, function(since)
        if since and since ~= "" then
            vim.ui.input({ prompt = "Until date (YYYY-MM-DD or 'now'): " }, function(until_date)
                local git_cmd = { "git", "log", "--oneline", "--since=" .. since }
                if until_date and until_date ~= "" then
                    table.insert(git_cmd, "--until=" .. until_date)
                end

                require('telescope.builtin').git_commits({
                    prompt_title = "Commits: " .. since .. " to " .. (until_date or "now"),
                    git_command = git_cmd
                })
            end)
        end
    end)
end

-- Graph log
M.graph_log = function()
    require('telescope.builtin').git_commits({
        prompt_title = "Git Graph",
        git_command = { "git", "log", "--oneline", "--graph", "--all", "--decorate" }
    })
end

-- Search commits by message
M.search_commits = function()
    vim.ui.input({ prompt = "Search commit messages: " }, function(query)
        if query and query ~= "" then
            require('telescope.builtin').git_commits({
                prompt_title = "Search: " .. query,
                git_command = { "git", "log", "--oneline", "--grep=" .. query }
            })
        end
    end)
end

-- Stash operations
------------------

-- List stashes interactively
M.stash_list = function()
    local stashes = vim.fn.systemlist("git stash list")
    if #stashes == 0 then
        vim.notify("No stashes found", vim.log.levels.INFO)
        return
    end

    vim.ui.select(stashes, {
        prompt = "Select stash:",
        format_item = function(item)
            return item
        end,
    }, function(choice, idx)
        if choice then
            vim.ui.select({ "Apply", "Pop", "Drop", "Show" }, {
                prompt = "Action for stash:",
            }, function(action)
                if action == "Apply" then
                    vim.cmd('Git stash apply stash@{' .. (idx - 1) .. '}')
                    vim.notify("Applied stash", vim.log.levels.INFO)
                elseif action == "Pop" then
                    vim.cmd('Git stash pop stash@{' .. (idx - 1) .. '}')
                    vim.notify("Popped stash", vim.log.levels.INFO)
                elseif action == "Drop" then
                    vim.cmd('Git stash drop stash@{' .. (idx - 1) .. '}')
                    vim.notify("Dropped stash", vim.log.levels.INFO)
                elseif action == "Show" then
                    vim.cmd('Git stash show -p stash@{' .. (idx - 1) .. '}')
                end
            end)
        end
    end)
end

-- Quick stash with message
M.quick_stash = function()
    vim.ui.input({ prompt = "Stash message (optional): " }, function(message)
        local cmd = "Git stash"
        if message and message ~= "" then
            cmd = cmd .. ' -m "' .. message .. '"'
        end
        vim.cmd(cmd)
        vim.notify("Created stash" .. (message and ": " .. message or ""), vim.log.levels.INFO)
    end)
end

-- Apply stash interactively
M.stash_apply = function()
    local stashes = vim.fn.systemlist("git stash list")
    if #stashes == 0 then
        vim.notify("No stashes found", vim.log.levels.INFO)
        return
    end

    vim.ui.select(stashes, {
        prompt = "Apply stash:",
    }, function(choice, idx)
        if choice then
            vim.cmd('Git stash apply stash@{' .. (idx - 1) .. '}')
            vim.notify("Applied stash", vim.log.levels.INFO)
        end
    end)
end

-- Pop stash interactively
M.stash_pop = function()
    local stashes = vim.fn.systemlist("git stash list")
    if #stashes == 0 then
        vim.notify("No stashes found", vim.log.levels.INFO)
        return
    end

    vim.ui.select(stashes, {
        prompt = "Pop stash:",
    }, function(choice, idx)
        if choice then
            vim.cmd('Git stash pop stash@{' .. (idx - 1) .. '}')
            vim.notify("Popped stash", vim.log.levels.INFO)
        end
    end)
end

-- Drop stash interactively
M.stash_drop = function()
    local stashes = vim.fn.systemlist("git stash list")
    if #stashes == 0 then
        vim.notify("No stashes found", vim.log.levels.INFO)
        return
    end

    vim.ui.select(stashes, {
        prompt = "Drop stash:",
    }, function(choice, idx)
        if choice then
            vim.ui.select({ "Yes", "No" }, {
                prompt = "Really drop this stash?",
            }, function(confirm)
                if confirm == "Yes" then
                    vim.cmd('Git stash drop stash@{' .. (idx - 1) .. '}')
                    vim.notify("Dropped stash", vim.log.levels.INFO)
                end
            end)
        end
    end)
end

-- Clear all stashes
M.stash_clear = function()
    local stashes = vim.fn.systemlist("git stash list")
    if #stashes == 0 then
        vim.notify("No stashes found", vim.log.levels.INFO)
        return
    end

    vim.ui.select({ "Yes", "No" }, {
        prompt = "Clear ALL stashes? (" .. #stashes .. " stashes will be deleted)",
    }, function(choice)
        if choice == "Yes" then
            vim.cmd('Git stash clear')
            vim.notify("Cleared all stashes", vim.log.levels.INFO)
        end
    end)
end

-- View stash content
M.stash_view = function()
    local stashes = vim.fn.systemlist("git stash list")
    if #stashes == 0 then
        vim.notify("No stashes found", vim.log.levels.INFO)
        return
    end

    vim.ui.select(stashes, {
        prompt = "View stash:",
    }, function(choice, idx)
        if choice then
            vim.cmd('Git stash show -p stash@{' .. (idx - 1) .. '}')
        end
    end)
end

-- Quick Actions
----------------

-- Smart commit (stage + commit)
M.smart_commit = function()
    -- Check if there are changes to stage
    local status = vim.fn.system("git status --porcelain")
    if status == "" then
        vim.notify("No changes to commit", vim.log.levels.INFO)
        return
    end

    vim.ui.select({ "Stage all and commit", "Stage current file and commit", "Commit staged only" }, {
        prompt = "Commit type:",
    }, function(choice)
        if choice == "Stage all and commit" then
            vim.cmd('Git add .')
        elseif choice == "Stage current file and commit" then
            local file = vim.fn.expand('%')
            if file ~= '' then
                vim.cmd('Git add ' .. file)
            else
                vim.notify("No file open", vim.log.levels.WARN)
                return
            end
        end

        vim.ui.input({ prompt = "Commit message: " }, function(message)
            if message and message ~= "" then
                vim.cmd('Git commit -m "' .. message .. '"')
                vim.notify("Committed: " .. message, vim.log.levels.INFO)
            end
        end)
    end)
end

-- Amend last commit
M.amend_commit = function()
    vim.ui.select({ "Amend message only", "Amend with staged changes", "Amend with all changes" }, {
        prompt = "Amend type:",
    }, function(choice)
        if choice == "Amend message only" then
            vim.cmd('Git commit --amend')
        elseif choice == "Amend with staged changes" then
            vim.cmd('Git commit --amend --no-edit')
            vim.notify("Amended commit with staged changes", vim.log.levels.INFO)
        elseif choice == "Amend with all changes" then
            vim.cmd('Git add . && git commit --amend --no-edit')
            vim.notify("Amended commit with all changes", vim.log.levels.INFO)
        end
    end)
end

-- Push with options
M.push_with_options = function()
    local current_branch = vim.fn.system("git branch --show-current"):gsub("\n", "")

    vim.ui.select({ "origin", "upstream", "all", "other" }, {
        prompt = "Push to remote:",
    }, function(remote_choice)
        if remote_choice == "other" then
            vim.ui.input({ prompt = "Remote name: " }, function(remote)
                if remote and remote ~= "" then
                    vim.cmd('Git push ' .. remote .. ' ' .. current_branch)
                end
            end)
        elseif remote_choice == "all" then
            vim.cmd('Git push --all')
            vim.notify("Pushed to all remotes", vim.log.levels.INFO)
        elseif remote_choice then
            vim.ui.select({ "Normal push", "Force push", "Force with lease" }, {
                prompt = "Push type:",
            }, function(push_type)
                if push_type == "Normal push" then
                    vim.cmd('Git push ' .. remote_choice .. ' ' .. current_branch)
                elseif push_type == "Force push" then
                    vim.cmd('Git push --force ' .. remote_choice .. ' ' .. current_branch)
                elseif push_type == "Force with lease" then
                    vim.cmd('Git push --force-with-lease ' .. remote_choice .. ' ' .. current_branch)
                end
                if push_type then
                    vim.notify("Pushed to " .. remote_choice, vim.log.levels.INFO)
                end
            end)
        end
    end)
end

-- Pull with options
M.pull_with_options = function()
    vim.ui.select({ "origin", "upstream", "other" }, {
        prompt = "Pull from remote:",
    }, function(remote_choice)
        if remote_choice == "other" then
            vim.ui.input({ prompt = "Remote name: " }, function(remote)
                if remote and remote ~= "" then
                    vim.cmd('Git pull ' .. remote)
                end
            end)
        elseif remote_choice then
            vim.ui.select({ "Normal pull", "Rebase", "Fast-forward only" }, {
                prompt = "Pull type:",
            }, function(pull_type)
                if pull_type == "Normal pull" then
                    vim.cmd('Git pull ' .. remote_choice)
                elseif pull_type == "Rebase" then
                    vim.cmd('Git pull --rebase ' .. remote_choice)
                elseif pull_type == "Fast-forward only" then
                    vim.cmd('Git pull --ff-only ' .. remote_choice)
                end
                if pull_type then
                    vim.notify("Pulled from " .. remote_choice, vim.log.levels.INFO)
                end
            end)
        end
    end)
end

-- Fetch all remotes
M.fetch_all = function()
    vim.cmd('Git fetch --all')
    vim.notify("Fetched from all remotes", vim.log.levels.INFO)
end

-- Interactive rebase
M.interactive_rebase = function()
    vim.ui.input({ prompt = "Rebase how many commits back? " }, function(count)
        if count and tonumber(count) then
            vim.cmd('Git rebase -i HEAD~' .. count)
        end
    end)
end

-- Cherry-pick interactive
M.cherry_pick = function()
    require('telescope.builtin').git_commits({
        prompt_title = "Cherry-pick Commit",
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                require('telescope.actions').close(prompt_bufnr)
                vim.cmd('Git cherry-pick ' .. selection.value)
                vim.notify("Cherry-picked: " .. selection.value, vim.log.levels.INFO)
            end)
            return true
        end
    })
end

-- Undo last commit (soft reset)
M.undo_commit = function()
    vim.ui.select({ "Soft reset (keep changes)", "Mixed reset (unstage changes)", "Hard reset (lose changes)" }, {
        prompt = "Reset type:",
    }, function(choice)
        if choice == "Soft reset (keep changes)" then
            vim.cmd('Git reset --soft HEAD~1')
            vim.notify("Undid last commit (changes kept)", vim.log.levels.INFO)
        elseif choice == "Mixed reset (unstage changes)" then
            vim.cmd('Git reset --mixed HEAD~1')
            vim.notify("Undid last commit (changes unstaged)", vim.log.levels.INFO)
        elseif choice == "Hard reset (lose changes)" then
            vim.ui.select({ "Yes, I'm sure", "No, cancel" }, {
                prompt = "This will permanently lose changes!",
            }, function(confirm)
                if confirm == "Yes, I'm sure" then
                    vim.cmd('Git reset --hard HEAD~1')
                    vim.notify("Hard reset completed", vim.log.levels.WARN)
                end
            end)
        end
    end)
end

-- Remote operations
-------------------

-- List remotes
M.remote_list = function()
    local remotes = vim.fn.systemlist("git remote -v")
    if #remotes == 0 then
        vim.notify("No remotes configured", vim.log.levels.INFO)
        return
    end

    vim.ui.select(remotes, {
        prompt = "Remotes:",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        -- Just display, no action needed
    end)
end

-- Add remote
M.remote_add = function()
    vim.ui.input({ prompt = "Remote name: " }, function(name)
        if name and name ~= "" then
            vim.ui.input({ prompt = "Remote URL: " }, function(url)
                if url and url ~= "" then
                    vim.cmd('Git remote add ' .. name .. ' ' .. url)
                    vim.notify("Added remote: " .. name, vim.log.levels.INFO)
                end
            end)
        end
    end)
end

-- Remove remote
M.remote_remove = function()
    local remotes = vim.fn.systemlist("git remote")
    if #remotes == 0 then
        vim.notify("No remotes configured", vim.log.levels.INFO)
        return
    end

    vim.ui.select(remotes, {
        prompt = "Remove remote:",
    }, function(choice)
        if choice then
            vim.ui.select({ "Yes", "No" }, {
                prompt = "Remove remote '" .. choice .. "'?",
            }, function(confirm)
                if confirm == "Yes" then
                    vim.cmd('Git remote remove ' .. choice)
                    vim.notify("Removed remote: " .. choice, vim.log.levels.INFO)
                end
            end)
        end
    end)
end

-- Prune remote branches
M.remote_prune = function()
    local remotes = vim.fn.systemlist("git remote")
    if #remotes == 0 then
        vim.notify("No remotes configured", vim.log.levels.INFO)
        return
    end

    vim.ui.select(remotes, {
        prompt = "Prune remote:",
    }, function(choice)
        if choice then
            vim.cmd('Git remote prune ' .. choice)
            vim.notify("Pruned remote: " .. choice, vim.log.levels.INFO)
        end
    end)
end

-- Fetch from remote
M.remote_fetch = function()
    local remotes = vim.fn.systemlist("git remote")
    if #remotes == 0 then
        vim.notify("No remotes configured", vim.log.levels.INFO)
        return
    end

    vim.ui.select(remotes, {
        prompt = "Fetch from remote:",
    }, function(choice)
        if choice then
            vim.cmd('Git fetch ' .. choice)
            vim.notify("Fetched from: " .. choice, vim.log.levels.INFO)
        end
    end)
end

-- Track remote branch
M.remote_track = function()
    require('telescope.builtin').git_branches({
        prompt_title = "Track Remote Branch",
        show_remote_tracking_branches = true,
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                require('telescope.actions').close(prompt_bufnr)
                local branch = selection.value:gsub("^%s*", ""):gsub("%s*$", "")
                if branch:match("^origin/") then
                    local local_branch = branch:gsub("^origin/", "")
                    vim.cmd('Git checkout -b ' .. local_branch .. ' ' .. branch)
                    vim.notify("Tracking branch: " .. branch, vim.log.levels.INFO)
                else
                    vim.notify("Please select a remote branch", vim.log.levels.WARN)
                end
            end)
            return true
        end
    })
end

-- Return all Git functions
return M
