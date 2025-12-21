-- Neovim configuration options
local opt = vim.opt
local g = vim.g

-- ==========================================
-- Leader Keys (Set early for lazy.nvim)
-- ==========================================
g.mapleader = " "
g.maplocalleader = "\\"

-- ==========================================
-- UI Settings
-- ==========================================
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false   -- Hide mode (already in statusline)
opt.signcolumn = "yes" -- Always show sign column
opt.cmdheight = 1      -- Command line height
opt.pumheight = 10     -- Popup menu height
opt.pumblend = 0       -- Popup menu opacity (0 = fully opaque)
opt.winblend = 0       -- Floating window opacity (0 = fully opaque)
opt.laststatus = 3     -- Global statusline (single statusline for all windows)
vim.wo.conceallevel = 2 -- Hide markup in markdown

-- ==========================================
-- Visual Indicators
-- ==========================================
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = {
	eob = " ",     -- Remove ~ from empty lines
	fold = " ",
	vert = "│",    -- Thin vertical separator for splits
	horiz = "─",   -- Thin horizontal separator for splits
	vertleft = "│",
	vertright = "│",
	verthoriz = "┼",
}

-- ==========================================
-- Indentation
-- ==========================================
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true
opt.autoindent = true
opt.shiftround = true -- Round indent to multiple of shiftwidth

-- ==========================================
-- Search Settings
-- ==========================================
opt.hlsearch = true         -- Highlight search (clear with <Esc>)
opt.incsearch = true
opt.ignorecase = true       -- Ignore case in search
opt.smartcase = true        -- Case-sensitive if uppercase letters used
opt.grepprg = "rg --vimgrep" -- Use ripgrep for grep

-- ==========================================
-- Editing and Navigation
-- ==========================================
opt.scrolloff = 8      -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8  -- Keep 8 columns left/right of cursor
opt.mouse = "a"        -- Enable mouse support
opt.wrap = false       -- Don't wrap lines
opt.linebreak = true   -- Break lines at word boundaries
opt.breakindent = true -- Maintain indent when wrapping
opt.showbreak = "↪ "   -- Character for wrapped lines

-- ==========================================
-- Clipboard and Splits
-- ==========================================
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.splitbelow = true         -- Horizontal splits go below
opt.splitright = true         -- Vertical splits go right

-- ==========================================
-- Backup and Undo
-- ==========================================
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Create undo directory if it doesn't exist
local undo_dir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undo_dir) == 0 then
	vim.fn.mkdir(undo_dir, "p")
end

-- ==========================================
-- Performance
-- ==========================================
opt.updatetime = 50
opt.timeout = true
opt.timeoutlen = 300   -- Faster which-key popup
opt.redrawtime = 10000 -- Time to wait for redraw
opt.synmaxcol = 240    -- Syntax highlighting limit for long lines
opt.lazyredraw = false -- Better UX in modern Neovim

-- ==========================================
-- Command Line and Completion
-- ==========================================
opt.wildmode = "longest:full,full"        -- Command line completion mode
opt.completeopt = "menu,menuone,noselect" -- Completion options
opt.shortmess:append("c")                 -- Don't show completion messages
opt.iskeyword:append("-")                 -- Treat dash as part of word

-- ==========================================
-- File Handling
-- ==========================================
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.confirm = true  -- Confirm before closing unsaved files
opt.autoread = true -- Auto-reload files changed outside vim
opt.autowrite = true -- Auto-save before switching buffers

-- ==========================================
-- Spell Checking
-- ==========================================
opt.spelllang = "en_us"
opt.spelloptions = "camel" -- Check camelCase words separately

-- ==========================================
-- Folding (Treesitter)
-- ==========================================
opt.foldenable = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99

-- ==========================================
-- Disable Built-in Plugins (Performance)
-- ==========================================
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_netrw = 1            -- Using nvim-tree instead
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
