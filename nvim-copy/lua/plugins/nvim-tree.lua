return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
	config = function()
		-- Custom keymaps for nvim-tree
		local function setup_keymaps(bufnr)
			local api = require("nvim-tree.api")
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- Essential navigation
			vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
			vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
			vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
			vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
			vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
			vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
			vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))

			-- File operations
			vim.keymap.set('n', 'a', api.fs.create, opts('Create File Or Directory'))
			vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
			vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
			vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
			vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
			vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
			vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
			vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
			vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
			vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
			vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))

			-- Tree operations
			vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
			vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
			vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
			vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
			vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
			vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
			vim.keymap.set('n', 'q', api.tree.close, opts('Close Tree'))

			-- Toggles
			vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Filter: Dotfiles'))
			vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Filter: Git Ignore'))
			vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Filter: Hidden'))
			vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
			vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
			vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))

			-- Bookmarks and info
			vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
			vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
			vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
			vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
			vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
			vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
		end

		require("nvim-tree").setup({
			disable_netrw = true,
			hijack_netrw = true,
			hijack_cursor = false,
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			reload_on_bufenter = false,
			
			update_focused_file = {
				enable = true,
				update_root = true,
			},

			view = {
				adaptive_size = false,
				width = 35,
				side = "left",
				number = true,
				relativenumber = true,
				signcolumn = "yes",
			},

			renderer = {
				add_trailing = false,
				group_empty = true,
				highlight_git = true,
				highlight_opened_files = "all",
				highlight_modified = "all",
				root_folder_label = ":~:s?$?/..?",
				indent_width = 2,
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
				},
				icons = {
					webdev_colors = true,
					git_placement = "before",
					modified_placement = "after",
					padding = " ",
					symlink_arrow = " ➛ ",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
						modified = true,
					},
					glyphs = {
						default = "󰈚",
						symlink = "",
						bookmark = "󰆤",
						modified = "●",
						folder = {
							arrow_closed = "▸",
							arrow_open = "▾",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
				special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "package.json", "go.mod" },
			},

			hijack_directories = {
				enable = true,
				auto_open = true,
			},

			live_filter = {
				prefix = "[FILTER]: ",
				always_show_folders = true,
			},

			filesystem_watchers = {
				enable = true,
				debounce_delay = 50,
			},

			git = {
				enable = true,
				ignore = false,
				show_on_dirs = true,
				show_on_open_dirs = true,
				timeout = 400,
			},

			modified = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},

			filters = {
				dotfiles = false,
				git_clean = false,
				no_buffer = false,
				custom = { "^.git$", "node_modules", ".cache" },
				exclude = { ".gitignore", ".env" },
			},

			diagnostics = {
			enable = false,
		},

			actions = {
				use_system_clipboard = true,
				change_dir = {
					enable = true,
					global = false,
				},
				expand_all = {
					max_folder_discovery = 300,
				},
				open_file = {
					quit_on_open = false,
					resize_window = true,
					window_picker = {
						enable = true,
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
			},

			trash = {
				cmd = "gio trash",
			},

			notify = {
				threshold = vim.log.levels.INFO,
			},

			ui = {
				confirm = {
					remove = true,
					trash = true,
				},
			},

			on_attach = setup_keymaps,
		})

		-- Auto-open nvim-tree when entering a directory
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function(data)
				local directory = vim.fn.isdirectory(data.file) == 1
				if directory then
					vim.cmd.cd(data.file)
					require("nvim-tree.api").tree.open()
				end
			end
		})
	end,
}
