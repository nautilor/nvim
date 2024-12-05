return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	init = function()
		vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
		vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
		vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<CR>")
		vim.keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>")
		vim.keymap.set({ "i", "n" }, "<C-p>", "<cmd>Telescope find_files<CR>")
		vim.keymap.set({ "i", "n" }, "<C-f>", "<cmd>Telescope live_grep<CR>")
		vim.keymap.set({ "i", "n" }, "<C-b>", "<cmd>Telescope buffers<CR>")
		vim.keymap.set({ "i", "n" }, "<C-g>", "<cmd>Telescope lsp_definitions<CR>")
	end,
	opts = {
		defaults = {
			prompt_prefix = "   ",
		},
	}
}
