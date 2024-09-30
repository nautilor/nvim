require('gitsigns').setup{
	current_line_blame = true
}

vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
