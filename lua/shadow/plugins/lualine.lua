return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		options = {
			theme = "gruvbox",
			--section_separators = { left = '', right = '' },
		},
		sections = {
			lualine_a = { { 'mode', } }, -- separator = { left = '' }, right_padding = 2 } },
			lualine_b = { 'branch', 'diff', 'diagnostics' },
			lualine_c = { 'filename' },
			lualine_x = { 'filetype' },
			lualine_y = { 'progress' },
			lualine_z = { { 'location', } } -- separator = { right = '' }, left_padding = 2 } }
		},
		tabline = {
			lualine_a = {
				{
					"buffers",
					separator = { left = "", right = "" }, -- right = "" },
					right_padding = 0,
					symbols = {
						alternate_file = "",
						modified = " ●",
					},
				},
			},
		},
	}
}
