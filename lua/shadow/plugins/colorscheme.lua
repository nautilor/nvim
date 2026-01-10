return {
	"folke/tokyonight.nvim",
	priority = 1000,
	opts = {
		colorscheme = "tokyonight-night",
		transparent = true,
		styles = {
			sidebars = "transparent",
			floats = "dark",
		},
	},

	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme(opts.colorscheme)
	end,

}
