return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	init = function()
		vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
		vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<CR>")
	end,
	opts = {
		defaults = {
			prompt_prefix = "   ",
		},
	}
}
