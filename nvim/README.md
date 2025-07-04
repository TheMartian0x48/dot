<div align="center">

# ⚡ Neovim Configuration

**Modern, modular, and blazingly fast Neovim setup**

[![Neovim](https://img.shields.io/badge/Neovim-0.10+-green.svg)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Made%20with-Lua-blue.svg)](https://www.lua.org/)
[![Lazy.nvim](https://img.shields.io/badge/Plugin%20Manager-lazy.nvim-orange.svg)](https://github.com/folke/lazy.nvim)

*A carefully crafted development environment* ⚡

---

</div>

## ✨ Features

- 🚀 **Lazy Loading** - Fast startup with lazy.nvim plugin manager
- 🎯 **Modular Structure** - Organized plugins by functionality
- 🛠️ **Full IDE Experience** - LSP, debugging, testing, and more
- 🎨 **Beautiful UI** - Modern colorschemes and statusline
- ⌨️ **Intuitive Keybindings** - Which-key for discoverability
- 🔍 **Powerful Search** - Telescope for fuzzy finding everything
- 🌳 **Smart Navigation** - File explorer and buffer management
- 📝 **Enhanced Editing** - Autocompletion, snippets, and formatting

## 🚀 Quick Start

This configuration is automatically installed with the main dotfiles setup:

```bash
# If using the main dotfiles
cd ~/.dotfiles && ./setup.sh

# Or install manually
git clone https://github.com/yourusername/dot.git ~/.config/nvim
nvim  # Will automatically install plugins on first run
```

## 📦 Plugin Categories

### 🔧 Core Functionality
| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **lazy.nvim** | Plugin manager | Lazy loading, lockfile, profiling |
| **which-key.nvim** | Key mapping guide | Interactive key discovery |
| **telescope.nvim** | Fuzzy finder | Files, buffers, grep, LSP symbols |
| **nvim-treesitter** | Syntax highlighting | Better parsing and highlighting |
| **oil.nvim** | File operations | Directory editing as buffer |

### 🎨 User Interface
| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **nvim-tree.lua** | File explorer | Tree view, git integration |
| **lualine.nvim** | Status line | Modern, customizable statusline |
| **colorscheme** | Visual theme | Multiple themes support |
| **nvim-web-devicons** | File icons | Beautiful file type icons |

### ✏️ Editor Enhancements
| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **nvim-cmp** | Autocompletion | LSP, snippets, buffer completion |
| **LuaSnip** | Snippet engine | Fast snippet expansion |
| **trouble.nvim** | Diagnostics | Better error/warning display |
| **mini.ai** | Text objects | Enhanced text object selection |

### 💻 Development Tools
| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **nvim-lspconfig** | LSP client | Language server integration |
| **mason.nvim** | LSP installer | Automatic LSP/tool installation |
| **nvim-dap** | Debugging | Debug adapter protocol |
| **gitsigns.nvim** | Git integration | Git hunks, blame, diff |
| **none-ls.nvim** | Formatting/Linting | Code formatting and linting |

### 📝 Productivity
| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **sticky-notes** | Quick notes | Persistent note-taking |
| **toggleterm.nvim** | Terminal integration | Multiple terminals |

## 📁 Project Structure

```
nvim/
├── 📄 init.lua                   # Entry point
├── 📄 lazy-lock.json             # Plugin version lockfile
├── 📁 lua/
│   ├── 📁 config/
│   │   ├── options.lua           # Neovim options
│   │   ├── lazy.lua              # Plugin manager setup
│   │   └── filetypes.lua         # File type associations
│   └── 📁 plugins/
│       ├── 📁 core/              # Essential functionality
│       │   ├── init.lua          # Core plugin loader
│       │   ├── telescope.lua     # Fuzzy finder
│       │   ├── which-key.lua     # Key mappings
│       │   ├── treesitter.lua    # Syntax highlighting
│       │   ├── navigation.lua    # Buffer/window navigation
│       │   ├── terminal.lua      # Terminal integration
│       │   └── fileops.lua       # File operations
│       ├── 📁 ui/                # User interface
│       │   ├── init.lua          # UI plugin loader
│       │   ├── colorscheme.lua   # Color themes
│       │   ├── statusline.lua    # Status bar
│       │   ├── ntree.lua         # File explorer
│       │   └── icon.lua          # File icons
│       ├── 📁 editor/            # Editor enhancements
│       │   ├── init.lua          # Editor plugin loader
│       │   ├── autocomplete.lua  # Completion engine
│       │   ├── trouble.lua       # Diagnostics
│       │   └── miniai.lua        # Text objects
│       ├── 📁 dev/               # Development tools
│       │   ├── init.lua          # Dev plugin loader
│       │   ├── lsp.lua           # Language servers
│       │   ├── dap.lua           # Debugging
│       │   ├── git.lua           # Git integration
│       │   └── none-ls.lua       # Formatting/linting
│       └── 📁 productivity/      # Productivity tools
│           ├── init.lua          # Productivity loader
│           └── stickynotes.lua   # Note-taking
├── 📁 snippets/                  # Code snippets
└── 📁 lang-servers/              # Language server configs
    └── 📁 java/                  # Java-specific setup
```

## ⌨️ Key Mappings

### Leader Key: `<Space>`

<details>
<summary><code>&lt;leader&gt;f</code> <strong>File Operations</strong></summary>

```
<leader>f
├── f     → Find files
├── d     → Find in directory
├── b     → Find buffers
├── g     → Find git files
├── h     → Find help
├── r     → Recent files
│   ├── a → All recent files
│   ├── p → Project recent
│   └── s → Session recent
├── s     → Search
│   ├── l → Live grep
│   ├── c → Grep with context
│   └── w → Grep word
├── n     → New
│   ├── f → New file
│   └── t → New from template
└── o     → Operations
    ├── r → Rename file
    ├── d → Delete file
    └── c → Copy file
```
</details>

<details>
<summary><code>&lt;leader&gt;b</code> <strong>Buffer Management</strong></summary>

```
<leader>b
├── n     → Next buffer
├── p     → Previous buffer
├── d     → Delete buffer
├── D     → Force delete buffer
├── l     → List buffers
├── b     → Buffer picker
├── a     → Alternate buffer
├── r     → Recent buffers
├── q     → Smart close buffer
├── 1-9   → Go to buffer 1-9
└── 0     → Go to last buffer

Navigation shortcuts:
├── <Tab>   → Next buffer
└── <S-Tab> → Previous buffer
```
</details>

<details>
<summary><code>&lt;leader&gt;w</code> <strong>Window Management</strong></summary>

```
<leader>w
├── h     → Go to left window
├── j     → Go to lower window
├── k     → Go to upper window
├── l     → Go to right window
├── s     → Split window below
├── v     → Split window right
├── c     → Close window
├── o     → Close other windows
└── =     → Equalize window sizes

Navigation & Resize:
├── <C-h/j/k/l>      → Navigate splits
├── <C-Up/Down>      → Resize height
└── <C-Left/Right>   → Resize width
```
</details>

<details>
<summary><code>&lt;leader&gt;e</code> <strong>File Explorer</strong></summary>

```
<leader>e
├── e     → Toggle explorer
├── f     → Focus explorer
├── F     → Find current file
├── r     → Refresh explorer
├── c     → Collapse explorer
└── o     → Open oil file manager

Quick access:
└── -     → Open parent directory
```
</details>

<details>
<summary><code>&lt;leader&gt;l</code> <strong>LSP Operations</strong></summary>

```
Go-to actions:
├── gd    → Go to definition
├── gD    → Go to declaration
├── gr    → Go to references
├── gi    → Go to implementations
├── gt    → Go to type definitions
└── K     → Show hover info

<leader>l
├── d     → Telescope definitions
├── i     → Telescope implementations
├── t     → Telescope type definitions
├── s     → Document symbols
├── f     → Format document
├── a     → Code actions
│   └── s → Source actions
├── n     → Rename symbol
├── h     → Hover documentation
├── k     → Signature help
├── x     → Extract
│   ├── f → Extract function
│   └── v → Extract variable
├── c     → Call hierarchy
│   ├── i → Incoming calls
│   └── o → Outgoing calls
├── w     → Workspace
│   ├── s → Workspace symbols
│   ├── a → Add workspace folder
│   ├── r → Remove workspace folder
│   └── x → Restart LSP
└── m     → Diagnostics
    ├── d → Show line diagnostics
    ├── l → Buffer diagnostics
    └── w → Workspace diagnostics
```
</details>

<details>
<summary><code>&lt;leader&gt;x</code> <strong>Diagnostics</strong></summary>

```
<leader>x
├── x     → Toggle diagnostics
├── X     → Buffer diagnostics
├── L     → Location list
├── Q     → Quickfix list
├── n     → Next diagnostic
└── p     → Previous diagnostic

Navigation shortcuts:
├── ]d    → Next diagnostic
├── [d    → Previous diagnostic
├── ]e    → Next error
├── [e    → Previous error
├── ]w    → Next warning
└── [w    → Previous warning
```
</details>

<details>
<summary><code>&lt;leader&gt;g</code> <strong>Git Operations</strong></summary>

```
<leader>g
├── g     → Git status (Neogit)
├── c     → Git commits
├── C     → Buffer commits
├── b     → Branch operations
│   ├── b → Branch checkout
│   ├── c → Create branch
│   ├── d → Delete branch
│   ├── r → Rename branch
│   ├── m → Merge branch
│   └── l → List branches
├── d     → Diff operations
│   ├── b → Diff with branch
│   ├── p → Diff with prev commit
│   ├── c → Diff with commit
│   ├── t → Diff two commits
│   ├── f → Diff file (last commit)
│   └── s → Diff staged changes
├── h     → Hunk operations
│   ├── p → Preview hunk
│   ├── r → Reset hunk
│   ├── s → Stage hunk
│   ├── S → Stage buffer
│   ├── u → Undo stage hunk
│   ├── n → Next hunk
│   └── N → Previous hunk
├── l     → Log operations
│   ├── l → Interactive log
│   ├── f → File history
│   └── c → Current file history
├── z     → Stash operations
│   ├── l → List stashes
│   ├── s → Quick stash
│   ├── a → Apply stash
│   └── p → Pop stash
├── x     → Extended operations
│   ├── c → Smart commit
│   ├── a → Amend commit
│   ├── p → Push with options
│   └── P → Pull with options
├── B     → Blame line (full)
└── t     → Toggle blame
```
</details>

<details>
<summary><code>&lt;leader&gt;s</code> <strong>Search Operations</strong></summary>

```
<leader>s
├── f     → Search files (smart)
├── g     → Search grep
├── w     → Search word under cursor
├── b     → Search buffers
├── h     → Search help
├── r     → Search recent
├── c     → Search colorschemes
├── k     → Search keymaps
├── m     → Search marks
├── j     → Search jumplist
├── q     → Search quickfix
└── l     → Search location list

Navigation shortcuts:
├── n/N       → Next/previous search (centered)
├── */#       → Search word forward/backward (centered)
└── g*/g#     → Search partial forward/backward (centered)
```
</details>

<details>
<summary><code>&lt;leader&gt;d</code> <strong>Debug Operations</strong></summary>

```
<leader>d
├── b     → Toggle breakpoint
├── B     → Conditional breakpoint
├── c     → Continue
├── i     → Step into
├── o     → Step over
├── O     → Step out
├── r     → Toggle REPL
├── u     → Toggle UI
├── t     → Terminate
└── l     → Run last

Function keys:
├── <F8>  → Continue
├── <F9>  → Step into
├── <F10> → Step over
└── <F11> → Step out
```
</details>

<details>
<summary><code>&lt;leader&gt;t</code> <strong>Terminal Operations</strong></summary>

```
<leader>t
├── t     → Toggle terminal
├── h     → Horizontal terminal
├── v     → Vertical terminal
├── a     → Toggle all terminals
├── m     → Terminal management
│   ├── 1-4 → Terminal 1-4
│   └── s   → Select terminal
├── s     → System tools
│   ├── h → Htop
│   ├── b → Btop
│   └── d → Disk usage (ncdu)
├── d     → Development REPLs
│   ├── p → Python REPL
│   └── b → Bpython
├── f     → Enhanced float terminal
├── c     → Custom command
├── u     → Utilities
│   ├── j → Jq (JSON processor)
│   ├── y → Yq (YAML processor)
│   ├── r → Ripgrep
│   └── b → Bat (enhanced cat)
└── w     → Web tools
    ├── c → Curl
    └── h → HTTPie

Terminal mode:
└── <Esc><Esc> → Exit terminal mode
```
</details>

<details>
<summary><code>&lt;leader&gt;q</code> <strong>Quick Actions</strong></summary>

```
<leader>q
├── q     → Quit all
├── w     → Save and quit all
└── f     → Force quit all

General shortcuts:
├── <C-s>     → Save file
├── <leader>h → Clear search highlight
├── <Esc>     → Clear search & redraw
├── <C-d>     → Smart scroll down & center
├── <C-u>     → Smart scroll up & center
├── <C-o>     → Jump back (centered)
├── <C-i>     → Jump forward (centered)
├── gg        → Go to top (centered)
├── G         → Go to bottom (centered)
└── {/}       → Previous/next paragraph (centered)
```
</details>

<details>
<summary><code>&lt;leader&gt;u</code> <strong>Utility & Configuration</strong></summary>

```
<leader>u
├── l     → Lazy plugin manager
├── m     → Mason LSP manager
├── c     → Edit config
├── r     → Reload config
├── i     → Install plugins
├── s     → Sync plugins
├── u     → Update plugins
└── p     → Profile plugins

<leader>c
└── s     → Select colorscheme
```
</details>

<details>
<summary><code>&lt;leader&gt;o</code> <strong>Toggle Options</strong></summary>

```
<leader>o
├── n     → Toggle line numbers
├── r     → Toggle relative numbers
├── w     → Toggle line wrap
├── s     → Toggle spell check
├── l     → Toggle listchars
├── c     → Toggle cursor line
├── h     → Toggle search highlight
└── f     → Toggle folding
```
</details>

<details>
<summary><code>&lt;leader&gt;z</code> <strong>Zen Mode</strong></summary>

```
<leader>z
├── z     → Zen mode
└── t     → Twilight
```
</details>

<details>
<summary><code>&lt;leader&gt;S</code> <strong>Session Management</strong></summary>

```
<leader>S
├── s     → Save session
├── r     → Restore session
└── d     → Delete session
```
</details>

<details>
<summary><code>&lt;leader&gt;v</code> <strong>View Control</strong></summary>

```
<leader>v
├── t     → Scroll to top
├── c     → Center screen
└── b     → Scroll to bottom
```
</details>

<details>
<summary><code>Visual</code> <strong>Visual Mode Mappings</strong></summary>

```
Visual mode specific:
├── <leader>ghs → Stage hunk
├── <leader>ghr → Reset hunk
├── <leader>la  → Code actions
├── <leader>lf  → Format selection
├── <leader>sg  → Search selection
├── </>         → Indent/unindent (keep selection)
└── J/K         → Move selection up/down
```
</details>

<details>
<summary><code>Insert</code> <strong>Insert Mode Mappings</strong></summary>

```
Insert mode specific:
├── jk/kj       → Escape
├── <C-h/j/k/l> → Navigate in insert mode
├── <C-a>       → Go to beginning of line
├── <C-e>       → Go to end of line
├── <C-d>       → Delete character
└── <C-k>       → Signature help
```
</details>


## 🔍 Troubleshooting

### Common Issues

**LSP not working:**
```bash
# Check if language server is installed
:Mason
# Or check LSP info
:LspInfo
```

**Slow startup:**
```bash
# Profile plugin loading
nvim --startuptime startup.log
# Or use lazy.nvim profiler
:Lazy profile
```

**Treesitter errors:**
```bash
# Update parsers
:TSUpdate
# Or install specific parser
:TSInstall lua python javascript
```

**Plugin not loading:**
```bash
# Check lazy.nvim status
:Lazy
# Force reload plugin
:Lazy reload plugin-name
```

## 📚 Learning Resources

### Neovim
- [Neovim Documentation](https://neovim.io/doc/)
- [Learn Vim the Hard Way](https://learnvimscriptthehardway.stevelosh.com/)
- [Vim Adventures](https://vim-adventures.com/) - Interactive Vim tutorial

### Lua in Neovim
- [Lua Guide for Neovim](https://github.com/nanotee/nvim-lua-guide)
- [lua-users wiki](http://lua-users.org/wiki/)

### Plugin Development
- [lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [Neovim Plugin Template](https://github.com/nvim-lua/nvim-lua-plugin-template)

## 📝 License

This Neovim configuration is part of the main dotfiles project and is licensed under the MIT License.

## 🙏 Acknowledgments

- **Neovim Team** - For the amazing editor
- **Plugin Authors** - For their incredible work
- **Community** - For sharing knowledge and configurations
- **lazy.nvim** - For making plugin management a breeze

---

<div align="center">

**⚡ Happy Vimming! ⚡**

*Made with ❤️ and lots of `:help`*

</div>
