return {
	'nvim-tree/nvim-tree.lua',
	dependencies = {
		"nvim-tree/nvim-web-devicons"
	},
	-- useful to define keymap shortcuts
	init = function()
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
	end,
	-- options that you will normally parse to .setup({})
	opts = {
		filters = { dotfiles = false },
		disable_netrw = true,
		hijack_cursor = true,
		sync_root_with_cwd = true,
		actions = { open_file = { quit_on_open = true } },
		update_focused_file = {
			enable = true,
			update_root = false,
		},
		view = {
			width = 30,
			preserve_window_proportions = true,
			float = {
				enable = true,
				quit_on_focus_loss = true,
				open_win_config = {
					relative = "editor",
					width = 30,
					border = "rounded",
				}
			}
		},
		renderer = {
			root_folder_label = false,
			highlight_git = true,
			indent_markers = { enable = true },
			icons = {
				glyphs = {
					default = "󰈚",
					folder = {
						default = "",
						empty = "",
						empty_open = "",
						open = "",
						symlink = "",
					},
					git = { unmerged = "" },
				},
			},
		}
	},
	config = function(_, opts)
		require("nvim-tree").setup(opts)
	end
}
