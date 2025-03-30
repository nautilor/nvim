return {
	"declancm/cinnamon.nvim",
	version = "*", -- use latest release
	opts = {
	},
	config = function(_, opts)
		local cinnamon = require("cinnamon")
		cinnamon.setup(opts)
		-- Centered scrolling:
		vim.keymap.set("n", "<C-U>", function() cinnamon.scroll("<C-U>zz") end)
		vim.keymap.set("n", "<C-D>", function() cinnamon.scroll("<C-D>zz") end)
		vim.keymap.set("n", "zz", function() cinnamon.scroll("zz") end)
		vim.keymap.set("n", "zt", function() cinnamon.scroll("zt") end)
		vim.keymap.set("n", "zb", function() cinnamon.scroll("zb") end)
		vim.keymap.set("n", "gg", function() cinnamon.scroll("gg") end)
		vim.keymap.set("n", "G", function() cinnamon.scroll("G") end)
	end,
}
