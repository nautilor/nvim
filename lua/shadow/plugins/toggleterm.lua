local colors = require("tokyonight.colors").setup()

return {
	'akinsho/toggleterm.nvim',
	version = "*",
	opts = {
		shade_terminal = false,
		highlights = {
			NormalFloat = {
				guifg = colors.fg_dark,
				guibg = colors.bg_dark,
			},
		},
		float_opts = {
			border = "solid",
		}
	},
}
