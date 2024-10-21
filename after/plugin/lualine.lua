
require("lualine").setup({
	options = {
		theme = "onedark"
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
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
})
