-- Colorscheme configuration for Neovim

return {
	"nautilor/matugen.nvim",
	priority = 1000,
	opts = {
		colorscheme = "matugen",
		transparent = true,
	},

	config = function(_, opts)
		require("matugen").setup(opts)
		vim.cmd.colorscheme(opts.colorscheme)
	end,

}
