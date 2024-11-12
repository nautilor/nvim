return {
	"ellisonleao/gruvbox.nvim",
	-- use darker version
	opts = { style = 'darker' },
	init = function()
		vim.g.gruvbox_contrast_dark = 'hard'
		vim.cmd([[ set background=dark ]])
		vim.cmd([[ colorscheme gruvbox ]])
	end,
	-- set colorscheme
	config = function(_, opts)
		require("gruvbox").setup(opts)
		vim.cmd([[ colorscheme gruvbox]])
	end
}
