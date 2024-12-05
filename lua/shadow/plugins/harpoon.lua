return {
	'ThePrimeagen/harpoon',
	init = function()
		vim.keymap.set("n", "<leader>hh", "<cmd>lua require('harpoon.mark').add_file()<CR>")
		vim.keymap.set("n", "<leader>mm", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")
		vim.keymap.set("n", "<leader>nn", "<cmd>lua require('harpoon.ui').nav_next()<CR>")
		vim.keymap.set("n", "<leader>pp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>")
	end
}
