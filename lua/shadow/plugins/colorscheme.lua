return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	init = function()
		vim.opt.fillchars = { eob = " " }
	end,
	-- set colorscheme
	config = function(_, opts)
		require("catppuccin").setup({
			flavour = "mocha",
			background = {
				light = "latte",
				dark = "mocha"
			},
			transparent_background = true,
			float = {
				transparent = false, -- enable transparent floating windows
				solid = true,    -- use solid styling for floating windows, see |winborder|
			},
		})
		vim.cmd.colorscheme "catppuccin"
	end
}
