return {
	"goolord/alpha-nvim",
	dependencies = {
		'echasnovski/mini.icons',
		'nvim-lua/plenary.nvim'
	},
	config = function(_, opts)
		local alpha = require('alpha')
		local dashboard = require('alpha.themes.dashboard')
		dashboard.section.header.val = {
			"⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣦⡀⠀⠀⠀⠀⠀⢀⣠⣤⣄⡀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⣴⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣧⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⢰⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀",
			"⠀⣠⣴⣦⣤⡀⠀⠈⢿⣿⣿⣿⣿⣿⡏⠀⢸⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀",
			"⣸⣿⣿⣿⣿⣿⣆⠀⠈⠻⢿⣿⣿⠟⠀⠀⠈⢿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀",
			"⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠀⠀⠀⣠⣶⣾⣷⣦⡀",
			"⢻⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣧",
			"⠈⢿⣿⣿⣿⣿⣿⡇⠀⠀⠀⣀⣤⣶⣶⣶⣤⡀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⡟",
			"⠀⠀⠙⠿⢿⠿⠋⠀⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⣿⣿⣿⣿⣿⣿⡿⠁",
			"⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⢿⣿⣿⣿⣿⡿⠁⠀",
			"⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠉⠛⠉⠁⠀⠀⠀",
			"⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠈⠛⠻⠿⠿⠟⠛⠛⠉⠉⠉⠉⠛⠿⢿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀",


		}
		dashboard.section.buttons.val = {
			dashboard.button("n", "  > New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("e", "  > File Manager", ":NvimTreeToggle<CR>"),
			dashboard.button("ff", "  > Find file", ":Telescope find_files<CR>"),
			dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
			dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
		}
		local fortune = require("alpha.fortune")
		dashboard.section.footer.val = fortune()

		alpha.setup(dashboard.opts)
	end
}
