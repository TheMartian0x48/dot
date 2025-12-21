-- Development tools and LSP
-- Load all plugin modules
local git_plugins = require("plugins.dev.git-plugins")
local lsp_plugins = require("plugins.dev.lsp-plugins")
local debug_plugins = require("plugins.dev.debug-plugins")

-- Combine all plugin modules
local all_plugins = {}
vim.list_extend(all_plugins, lsp_plugins)
vim.list_extend(all_plugins, git_plugins)
vim.list_extend(all_plugins, debug_plugins)

return all_plugins
