return {
	-- "ellisonleao/gruvbox.nvim",
	"nautilor/onedark.nvim",
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
		vim.cmd([[ colorscheme onedark ]])
		vim.opt.fillchars = { eob = " " }
	end,
	-- set colorscheme
	config = function(_, opts)
		require("onedark").setup(opts)
		require("onedark").load()
		vim.cmd([[ colorscheme onedark]])
	end
}
