return {
	"lewis6991/gitsigns.nvim",
	opts = {
		current_line_blame = true
	},
	init = function()
		vim.keymap.set("n", "<leader>gp", ":Gitsign preview_hunk<CR>", {})
	end
}
