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
		vim.keymap.set({ "n", "x" }, "k", function() cinnamon.scroll("k", { count_only = true }) end)
		vim.keymap.set({ "n", "x" }, "j", function() cinnamon.scroll("j", { count_only = true }) end)
		vim.keymap.set({ "n", "x" }, "<Up>", function() cinnamon.scroll("<Up>", { count_only = true }) end)
		vim.keymap.set({ "n", "x" }, "<Down>", function() cinnamon.scroll("<Down>", { count_only = true }) end)
		vim.keymap.set({ "n", "x" }, "gk", function() cinnamon.scroll("gk", { count_only = true }) end)
		vim.keymap.set({ "n", "x" }, "gj", function() cinnamon.scroll("gj", { count_only = true }) end)
		vim.keymap.set({ "n", "x" }, "g<Up>", function() cinnamon.scroll("g<Up>", { count_only = true }) end)
		vim.keymap.set({ "n", "x" }, "g<Down>", function() cinnamon.scroll("g<Down>", { count_only = true }) end)
	end,
}
