return {
	'navarasu/onedark.nvim',
	-- use darker version
	opts = { style = 'darker' },
	-- set colorscheme
	config = function(_, opts)
		require("onedark").setup(opts)
		vim.cmd([[ colorscheme onedark]])
	end
}

