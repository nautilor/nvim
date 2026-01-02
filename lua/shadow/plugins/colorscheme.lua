return {
	"nautilor/onedark.nvim",
	priority = 1000,
	-- set colorscheme
	config = function(_, opts)
		require("onedark").setup({
			style = "darker",
			transparent = true,
		})
		vim.cmd.colorscheme "onedark"
	end
}
