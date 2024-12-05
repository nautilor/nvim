return {
	"goolord/alpha-nvim",
	dependencies = {
		'echasnovski/mini.icons',
		'nvim-lua/plenary.nvim'
	},
	config = function()
		local alpha = require('alpha')
		local dashboard = require('alpha.themes.dashboard')
		dashboard.section.header.val = {
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡦⠬⠧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⢀⣠⣤⣤⣤⣀⠀⠀⠀⠙⠀⠀⠀⠀⢀⣠⣤⣤⣤⣀⠀⠀⠀⠀",
			"⠀⠀⢀⣶⠟⠁⠀⠀⠈⠙⣷⡄⠀⠀⠀⠀⢀⣴⠟⠉⠀⠀⠈⠙⢷⡄⠀⠀",
			"⠀⠀⣾⢣⡗⠀⠀⠀⠀⠀⠘⣷⣴⠾⠷⣶⣼⢧⡗⠀⠀⠀⠀⠀⠈⣿⠀⠀",
			"⠘⠛⣿⢸⡄⠀⠀⠀⠀⠀⠀⣿⠁⠀⠀⠈⣿⡸⡇⠀⠀⠀⠀⠀⠀⣾⠟⠃",
			"⠀⠀⠹⣧⡻⣦⠀⠀⠀⢀⣼⠏⠀⠀⠀⠀⠸⣧⡹⣦⠄⠀⠀⠀⣴⠏⠀⠀",
			"⠀⠀⠀⠈⠻⢶⣦⣤⡶⠟⠉⠀⠀⠀⠀⠀⠀⠈⠻⠷⣦⣤⡶⠟⠋⠀⠀⠀",
			"                           ",
			"                           ",
			"                           ",


		}
		dashboard.section.buttons.val = {
			dashboard.button("n", "  > New file", "<cmd>ene <BAR> startinsert <CR>"),
			dashboard.button("e", "  > File Manager", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("f", "  > Find file", "<cmd>Telescope find_files<CR>"),
			dashboard.button("r", "  > Recent", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}
		local fortune = require("alpha.fortune")
		dashboard.section.footer.val = fortune()

		alpha.setup(dashboard.opts)
	end
}
