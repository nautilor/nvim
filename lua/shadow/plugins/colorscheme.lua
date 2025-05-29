return {
	-- "ellisonleao/gruvbox.nvim",
	-- "nautilor/onedark.nvim",
	"nautilor/gruvbox.nvim",
	-- use darker version
	opts = {
		style = 'dark',
		transparent = true,
		lualine = {
			transparent = true, -- lualine center bar transparency
		},
	},
	init = function()
		-- vim.g.gruvbox_contrast_dark = 'hard'
		vim.cmd([[ set background=dark ]])
		vim.cmd([[ colorscheme gruvbox ]])
		vim.opt.fillchars = { eob = " " }
	end,
	-- set colorscheme
	config = function(_, opts)
		require("gruvbox").setup(opts)
		require("gruvbox").load()
		vim.cmd([[ colorscheme gruvbox]])
	end
}
