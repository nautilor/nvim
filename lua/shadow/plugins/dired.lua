return {
	"X3eRo0/dired.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function(_, opts)
		local dired = require("dired")
		dired.setup(opts)
	end
}
