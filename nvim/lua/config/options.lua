-- Neovim configuration options
local opt = vim.opt
local g = vim.g

-- Leader keys (set early for lazy.nvim)
g.mapleader = " "
g.maplocalleader = "\\"

-- UI Settings
opt.number = true
opt.relativenumber = true
opt.cursorline = true
-- opt.cursorlineopt = "number" -- Only highlight line number, not the entire line
opt.termguicolors = true
opt.showmode = false   -- already present in status line
opt.signcolumn = "yes" -- Always show sign column to prevent layout shift
opt.cmdheight = 1      -- Command line height
opt.pumheight = 10     -- Popup menu height
opt.pumblend = 0       -- Popup menu opacity (0 = fully opaque)
opt.winblend = 0       -- Floating window opacity (0 = fully opaque)
vim.wo.conceallevel = 2

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.autoindent = true
opt.softtabstop = 4
opt.tabstop = 4
opt.shiftround = true -- Round indent to multiple of shiftwidth

-- Visual indicators
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = {
    eob = " ",
    fold = " ",
}

-- Search settings
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true        -- Ignore case in search
opt.smartcase = true         -- Case-sensitive if uppercase letters are used
opt.grepprg = "rg --vimgrep" -- Use ripgrep for grep command

-- Backup and swap files
opt.backup = false
opt.swapfile = false
opt.undofile = true                             -- Enable persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Set undo directory

-- Create undo directory if it doesn't exist
local undo_dir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(undo_dir, "p")
end

-- Performance
opt.updatetime = 50
opt.timeout = true
opt.timeoutlen = 300
opt.redrawtime = 10000 -- Time to wait for redraw
opt.synmaxcol = 240    -- Syntax highlighting limit for long lines
opt.lazyredraw = false -- Don't redraw during macros (false for better UX in modern Neovim)

-- Editing and navigation
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
opt.mouse = "a" -- Enable mouse support
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.splitbelow = true -- Horizontal splits go below
opt.splitright = true -- Vertical splits go right
opt.wrap = false -- Don't wrap lines
opt.linebreak = true -- Break lines at word boundaries
opt.breakindent = true -- Maintain indent when wrapping
opt.showbreak = "↪ " -- Character to show at the beginning of wrapped lines

-- Command line and completion
opt.wildmode = "longest:full,full"        -- Command line completion mode
opt.completeopt = "menu,menuone,noselect" -- Completion options
opt.shortmess:append("c")                 -- Don't show completion messages
opt.iskeyword:append("-")                 -- Treat dash as part of word

-- File handling
opt.fileencoding = "utf-8" -- File encoding
opt.confirm = true         -- Confirm before closing unsaved files
opt.autoread = true        -- Auto-reload files changed outside vim
opt.autowrite = true       -- Auto-save before switching buffers

-- Spell checking
opt.spelllang = "en_us"    -- Spell check language
opt.spelloptions = "camel" -- Check camelCase words separately

-- Folding
g.markdown_folding = 1 -- enable markdown folding
opt.foldenable = false
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Colorscheme settings
g.gruvbox_baby_background_color = "dark"

-- Disable some built-in plugins for better performance
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
g.loaded_netrw = 1 -- Disable netrw (if using nvim-tree or similar)
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
