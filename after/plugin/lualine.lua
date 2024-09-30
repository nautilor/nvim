local palette = require("neofusion.palette")

require("lualine").setup({
	options = {
		theme = "neofusion"
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
				buffers_color = {
					active = { 
						bg = palette.light0,
						fg = palette.dark0
					},
					inactive = {
						bg = palette.light4,
						fg = palette.light0
					}
				},
			},
		},
	},
})
