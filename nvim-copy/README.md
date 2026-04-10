<div align="center">

# ⚡ Neovim Configuration

**Modern, modular, and blazingly fast Neovim setup**

[![Neovim](https://img.shields.io/badge/Neovim-0.10+-green.svg)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Made%20with-Lua-blue.svg)](https://www.lua.org/)
[![Lazy.nvim](https://img.shields.io/badge/Plugin%20Manager-lazy.nvim-orange.svg)](https://github.com/folke/lazy.nvim)

*A carefully crafted development environment* ⚡

---

</div>

## Requirements

- Neovim >= 0.9.0
- Git
- ripgrep (for telescope and spectre)
- fd (for telescope file finding)
- A Nerd Font (for icons)

## Plugin Manager

- **lazy.nvim** - Modern plugin manager with lazy loading

## Plugins

### UI & Appearance
- **nordic.nvim** - Colorscheme with pure black background
- **lualine.nvim** - Statusline
- **bufferline.nvim** - Buffer tabs
- **nvim-web-devicons** - File icons
- **dashboard-nvim** - Start screen
- **dropbar.nvim** - Winbar with context
- **which-key.nvim** - Keymap hints

### File Management
- **nvim-tree.lua** - File explorer
- **telescope.nvim** - Fuzzy finder

### Editor Enhancement
- **nvim-treesitter** - Syntax highlighting and parsing
- **nvim-cmp** - Autocompletion
- **nvim-surround** - Surround text objects
- **nvim-spectre** - Search and replace panel
- **Comment.nvim** - Smart commenting (via editor.lua)
- **render-markdown.nvim** - Markdown preview

### LSP & Development
- **nvim-lspconfig** - LSP configuration
- **conform.nvim** - Code formatting
- **trouble.nvim** - Better diagnostics UI

### Git Integration
- **gitsigns.nvim** - Git signs and hunks

### Terminal
- **toggleterm.nvim** - Terminal management

### Session Management
- **persistence.nvim** - Session auto-save/restore

## Keymappings

Leader key: `<Space>`
Local leader: `\`

### Basic Operations

```
<leader>w → Save file
<leader>q → Quit
<leader>Q → Force quit
<Esc>     → Clear search highlight
```

### Window Management

```
Navigation
├── <C-h>      → Move left
├── <C-j>      → Move down
├── <C-k>      → Move up
└── <C-l>      → Move right

Resize
├── <C-Up>     → Increase height
├── <C-Down>   → Decrease height
├── <C-Left>   → Decrease width
└── <C-Right>  → Increase width
```

### Text Editing

```
Visual Mode
├── J          → Move selection down
└── K          → Move selection up
```

### Buffer Management

```
<leader>b
├── b          → Pick buffer
├── f          → Fuzzy find buffer
├── p          → Previous buffer
├── d          → Delete buffer
├── D          → Force delete buffer
├── c          → Close other buffers
├── C          → Close all buffers
├── l          → Close buffers to left
├── r          → Close buffers to right
└── s
    ├── e      → Sort by extension
    ├── d      → Sort by directory
    └── r      → Sort by relative path

Navigation
├── ]b         → Next buffer
└── [b         → Previous buffer

Movement
├── >b         → Move buffer right
└── <b         → Move buffer left
```

### File Explorer

```
<leader>e
├── e          → Toggle explorer
└── f          → Find current file
```

### Terminal

```
<leader>t
├── f          → Float terminal
├── h          → Horizontal terminal
├── v          → Vertical terminal
└── l          → Toggle Lazygit

Terminal Mode
├── <C-h/j/k/l> → Navigate windows
└── <Esc>       → Exit terminal mode
```

### Search & Replace (Telescope)

```
<leader>s
├── <CR>       → Resume previous search
├── f          → Find files
├── F          → Find files (hidden)
├── g          → Git tracked files
├── o          → Recent files
├── w          → Word at cursor
├── /          → Live grep
├── G          → Live grep (hidden)
├── l          → Lines in buffer
├── k          → Keymaps
├── h          → Help tags
├── m          → Man pages
├── c          → Commands
├── '          → Marks
├── r          → Registers
├── n          → Notifications
└── s          → Colorschemes
```

### Search & Replace (Spectre)

```
<leader>r
├── r          → Open Spectre panel
├── w          → Replace current word (Normal mode)
├── w          → Replace selection (Visual mode)
└── f          → Replace in current file

In-Panel Keymaps
├── dd         → Toggle current item
├── <CR>       → Go to file
├── R          → Replace current line
├── <leader>R  → Replace all matches
├── Q          → Send to quickfix
├── ?          → Show options
├── V          → Change view mode
└── t
    ├── u      → Toggle auto-update
    ├── i      → Toggle ignore case
    └── h      → Toggle hidden files
```

### Git Operations

```
<leader>g
├── j          → Next hunk
├── k          → Prev hunk
├── p          → Preview hunk
├── s          → Stage hunk
├── u          → Undo stage hunk
├── S          → Stage buffer
├── r          → Reset hunk
├── R          → Reset buffer
├── b          → Blame line
├── B          → Toggle blame line
├── d          → Diff this
└── D          → Toggle deleted

Navigation
├── ]h         → Next hunk
└── [h         → Prev hunk
```

### LSP

```
<leader>l
├── i          → LSP info
├── d          → Line diagnostics
├── D          → All diagnostics
├── h          → Signature help
├── r          → Rename
├── a          → Code action
├── A          → Source action
├── f          → Format document
├── s          → Document symbols
├── G          → Workspace symbols
└── R          → References

Navigation
├── gD         → Go to declaration
├── gd         → Go to definition
├── gy         → Go to type definition
├── gri        → Go to implementation
├── grr        → References
├── gO         → Document outline

Actions
├── K          → Hover documentation
├── grn        → Rename
├── gra        → Code action

Diagnostics
├── ]d         → Next diagnostic
├── [d         → Prev diagnostic
├── ]e         → Next error
├── [e         → Prev error
├── ]w         → Next warning
├── [w         → Prev warning
└── gl         → Line diagnostics

Workspace
<leader>w
├── a          → Add workspace folder
├── r          → Remove workspace folder
└── l          → List workspace folders
```

### Diagnostics (Trouble)

```
<leader>x
├── x          → Diagnostics (Trouble)
├── X          → Buffer diagnostics (Trouble)
├── L          → Location list (Trouble)
├── Q          → Quickfix list (Trouble)
├── q          → Open quickfix
└── l          → Open location list

<leader>c
├── s          → Symbols (Trouble)
└── l          → LSP definitions/references (Trouble)
```

### Session Management

```
<leader>q
├── s          → Restore session
├── l          → Restore last session
└── d          → Don't save current session
```

### UI Toggles

```
<leader>u
├── d          → Toggle diagnostics
├── D          → Dismiss notifications
├── v          → Toggle diagnostic virtual text
├── f          → Toggle autoformat (buffer)
├── F          → Toggle autoformat (global)
├── w          → Toggle line wrap
├── n          → Cycle line numbering
├── h          → Toggle inlay hints
├── s          → Toggle spellcheck
├── b          → Toggle background (dark/light)
├── g          → Toggle signcolumn
├── l          → Toggle statusline
└── t          → Toggle tabline
```

### Quickfix & Location Lists

```
Quickfix
├── ]q         → Next item
├── [q         → Prev item
├── ]Q         → Last item
└── [Q         → First item

Location List
├── ]l         → Next item
├── [l         → Prev item
├── ]L         → Last item
└── [L         → First item
```

## Configuration Structure

```
nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/
│   │   └── keymaps.lua        # All keymappings
│   └── plugins/               # Plugin configurations
│       ├── bufferline.lua
│       ├── cmp.lua
│       ├── colorscheme.lua
│       ├── dashboard.lua
│       ├── devicons.lua
│       ├── dropbar.lua
│       ├── editor.lua
│       ├── formatting.lua
│       ├── gitsigns.lua
│       ├── lsp.lua
│       ├── lualine.lua
│       ├── nvim-tree.lua
│       ├── persistence.lua
│       ├── render-markdown.lua
│       ├── spectre.lua
│       ├── surround.lua
│       ├── telescope.lua
│       ├── toggleterm.lua
│       ├── treesitter.lua
│       ├── trouble.lua
│       └── which-key.lua
└── lazy-lock.json             # Plugin version lock
```

---

<div align="center">

**⚡ Happy Vimming! ⚡**

*Made with ❤️ and lots of `:help`*

</div>