return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = true,
	init = function()
		vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm direction=float<CR>')
		vim.keymap.set({ "i", "n", "t" }, '<C-t>', '<cmd>ToggleTerm direction=float<CR>')
	end
}
